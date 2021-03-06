//
//  ViewController.swift
//  Sports
//
//  Created by Ahmed on 3/21/21.
//

import UIKit
import SDWebImage
import Alamofire

class SportsViewController: UIViewController {
    
    @IBOutlet weak var sportCollectionView: UICollectionView!
    var sportsList = [SportData]()
    let url = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sports" //set title for view controller
        
        sportCollectionView.dataSource = self
        sportCollectionView.delegate = self
        sportCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        //requestDatafromApi()// call sports API
        
        self.fetchData()
    }
    func fetchData(){
    
        Alamofire.request(url).responseJSON { (response) in
            let result = response.data
            var response:Sport?
            do{
                response = try JSONDecoder().decode(Sport.self,from: result!)
                self.sportsList = response!.sports!
                self.sportCollectionView.reloadData()

            }catch{
                print(error)
            }
        }
    }
    
    /*func requestDatafromApi(){
        let url = URL(string: "https://www.thesportsdb.com/api/v1/json/1/all_sports.php")
        let urlRequest = URLRequest(url: url!)
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = urlSession.dataTask(with: urlRequest){
            [self] (data,resonse,error) in
            
            var response:Sport?
            do{
                response = try JSONDecoder().decode(Sport.self, from: data!)
                DispatchQueue.main.async {
                    self.sportCollectionView.reloadData()
                }
            }catch{
                print(error)
            }
            
            guard response != nil else{
                return
            }
            self.sportsList = response!.sports
        }
        task.resume()
    }*/
    
}

struct Sport:Codable{
    let sports:[SportData]?
}

struct SportData:Codable{
    var idSport:String?
    var strSport:String?
    var strFormat:String?
    var strSportThumb:String?
    var strSportThumbGreen:String?
    var strSportDescription:String?
}

extension SportsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sportsList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCollectionViewCell", for: indexPath) as! SportCollectionViewCell
        
        let sport = sportsList[indexPath.row]
        cell.sportImage.sd_setImage(with: URL(string: sport.strSportThumb!), placeholderImage:UIImage(named: "image"))
        cell.sportTitle.text = sport.strSport
        //        cell.sportImage.image = UIImage(named: "image")
        return cell
    }
}

extension SportsViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //make size half width
        let size = (collectionView.frame.size.width - 10) / 2
        
        return CGSize(width: size, height: size)
    }
}
extension SportsViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let leaguesViewController = self.storyboard?.instantiateViewController(identifier: "LeaguesViewController") as! LeaguesViewController
        
        /*send name of sport to leagues view
         to get only items related to this sport*/
        leaguesViewController.spName = sportsList[indexPath.row].strSport

        self.navigationController?.pushViewController(leaguesViewController, animated: true)
    }
}
