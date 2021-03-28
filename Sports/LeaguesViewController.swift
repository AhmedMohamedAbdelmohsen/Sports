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
    let url = "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        leagueTableView.delegate = self
        leagueTableView.dataSource = self

        self.fetchData()
    }
    
    func fetchData(){
    
        Alamofire.request(url).responseJSON {(response) in
            let result = response.data
            var response:Leagues?
            do{
                response = try JSONDecoder().decode(Leagues.self,from: result!)
                self.leagueList = response!.leagues!
                self.leagueTableView.reloadData()

            }catch{
                print(error)
            }
        }
    }
    
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
        return leagueList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LeagueTableViewCell
        let league = leagueList[indexPath.row]
        
        cell.leagueName.text = league.strLeague
        cell.leagueImage.image = UIImage(named:"image")
        cell.leagueImage.roundedImage()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

