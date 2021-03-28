//
//  LeaguesViewController.swift
//  Sports
//
//  Created by Ahmed on 3/28/21.
//

import UIKit
import Alamofire

class LeaguesViewController: UIViewController {
    
    @IBOutlet weak var leagueTableView: UITableView!
    var spName:String?
    var leagueList = [League]()
    var newLeagueList = [League]()
    var lastLeagueList = [Detail]()
    let url = "https://www.thesportsdb.com/api/v1/json/1/"
    let urlDefaultImage = "https://www.allsportsphysio.com.au/wp-content/uploads/2020/08/Return-to-sport-tile-landscape-300x183.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leagueTableView.delegate = self
        leagueTableView.dataSource = self
        
        self.fetchData()
        //self.getLeagueDetals()
    }
    
    func fetchData(){
        Alamofire.request(url + "all_leagues.php").responseJSON {(response) in
            let result = response.data
            var response:Leagues?
            do{
                response = try JSONDecoder().decode(Leagues.self,from: result!)
                self.leagueList = response!.leagues!
                for element in self.leagueList{
                    if (element.strSport == self.spName){
                        self.newLeagueList.append(element)
                    }
                }
                self.getLeagueDetails()
                
            }catch{
                print(error)
            }
        }
    }
    
    func getLeagueDetails(){
        for element in self.newLeagueList{
            let id = Int(element.idLeague!)
            Alamofire.request(url + "lookupleague.php?id=\(id!)").responseJSON {(response) in
                let result = response.data
                var response:LeagueDetails?
                do{
                    response = try JSONDecoder().decode(LeagueDetails.self,from: result!)
                   
                    self.lastLeagueList.append(response!.leagues![0])
                    self.leagueTableView.reloadData()

                }catch{
                    print(error)
                }
            }
        }
    }
    
}
struct LeagueDetails:Codable{
    let leagues:[Detail]?
}

struct Detail:Codable{
    var strLeague:String?
    var strYoutube:String?
    var strBadge:String?
}
struct Leagues:Codable{
    let leagues:[League]?
}

struct League:Codable{
    var idLeague:String?
    var strLeague:String?
    var strSport:String?
    var strLeagueAlternate:String?
}

extension LeaguesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hi Ahmed")
    }
}

extension LeaguesViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastLeagueList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LeagueTableViewCell
        
        let league = lastLeagueList[indexPath.row]
        
        cell.leagueName.text = league.strLeague
        
        cell.leagueImage.sd_setImage(with: URL(string: league.strBadge ?? urlDefaultImage), placeholderImage:UIImage(named: "image"))
        
        cell.leagueImage.roundedImage()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

