//
//  UpcomingViewController.swift
//  
//
//  Created by Elif Bihter Kuşçu on 18.08.2022.
//
import Foundation
import UIKit
import Firebase

class UpcomingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var upcomingTableView: UITableView!
    
    private var upcomingTableViewModel: UpcomingTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "UpcomingViewCell", bundle: nil)
        upcomingTableView.register(nib, forCellReuseIdentifier: "upcomingCell")
        upcomingTableView.dataSource = self
        upcomingTableView.delegate = self
        upcomingTableView.backgroundView = UIImageView(image: UIImage(named: "spaceXIOsBg"))
        
       getsData()
    }
    
    func getsData() {
        let url = URL(string: "https://api.spacexdata.com/v4/launches/upcoming")
        
        
        UpcomingManager().downloadUpcomings(url: url!) { (upcoming) in
            if let upcoming = upcoming {
                self.upcomingTableViewModel = UpcomingTableViewModel(upcomingList: upcoming)

                DispatchQueue.main.async {
                    self.upcomingTableView.reloadData()
            }
        }
    }
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingTableViewModel == nil ? 0 : self.upcomingTableViewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! UpcomingViewCell
        let upcomingViewModel = self.upcomingTableViewModel.upcomingAtIndexPath(indexPath.row)
        cell.upcomingCellName.text = upcomingViewModel.upcomingName
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 136
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let upcomingViewModel = self.upcomingTableViewModel.upcomingAtIndexPath(indexPath.row)
        let dc = storyboard?.instantiateViewController(withIdentifier: "UpcomingDetailsViewController") as! UpcomingDetailsViewController
        dc.upcomingData = upcomingViewModel.upcoming
        self.navigationController?.pushViewController(dc, animated: true)
    }
}
