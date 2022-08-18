//
//  ViewController.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 8.08.2022.
//
import Foundation
import UIKit
import Firebase

class RocketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var rocketsTableViewModel: RocketsTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "rocketcell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "rocketcell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "spaceXIOsBg"))
        getData()
    }
    
    func getData() {
        let url = URL(string: "https://api.spacexdata.com/v4/rockets")
        Webservice().downloadRockets(url: url!) { (rockets) in
            if let rockets = rockets {
                self.rocketsTableViewModel = RocketsTableViewModel(rocketList: rockets)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rocketsTableViewModel == nil ? 0 : self.rocketsTableViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RocketViewCell
        let rocketsViewModel = self.rocketsTableViewModel.rocketsAtIndexPath(indexPath.row)
        cell.rocketName.text = rocketsViewModel.rocketsName
        cell.rocketImage.load(urlString: rocketsViewModel.rocketsImage[0])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 299
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rocketsViewModel = self.rocketsTableViewModel.rocketsAtIndexPath(indexPath.row)
        let dc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        dc.detailsData=rocketsViewModel.rockets
        self.navigationController?.pushViewController(dc, animated: true)
    }
}
