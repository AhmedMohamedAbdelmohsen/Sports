//
//  LeagueDetailsViewController.swift
//  Sports
//
//  Created by Ahmed on 3/30/21.
//

import UIKit

class LeagueDetailsViewController: UIViewController {

    var leagueId:String?
    var leagueName:String?
    var leagueIamge:String?
    let urlDefaultImage = "https://www.allsportsphysio.com.au/wp-content/uploads/2020/08/Return-to-sport-tile-landscape-300x183.jpg"
    
    @IBOutlet weak var leagueNameLable: UILabel!

    @IBOutlet weak var leagueImageView: UIImageView!
    
    @IBOutlet weak var leagueDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set name of league
        leagueNameLable.text = leagueName
        //set image of league
        leagueImageView.sd_setImage(with: URL(string: leagueIamge ?? urlDefaultImage), placeholderImage:UIImage(named: "image"))
        
        leagueImageView.roundedImage()
        
        leagueDetailsTableView.delegate = self
        leagueDetailsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

}

extension LeagueDetailsViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CollectionTableViewCell
        
        cell.eventTitle.text = leagueId
        return cell
    }
}

extension LeagueDetailsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}
