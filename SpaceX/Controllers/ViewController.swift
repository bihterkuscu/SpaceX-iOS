//
//  ViewController.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 8.08.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var rockets: [Rockets] = [
        Rockets(rocketName: "falcon", rocketImage: "FalconTestPng"),
        Rockets(rocketName: "falcon", rocketImage: "FalconTestPng"),
        Rockets(rocketName: "falcon", rocketImage: "FalconTestPng"),
        Rockets(rocketName: "falcon", rocketImage: "FalconTestPng"),
        Rockets(rocketName: "falcon", rocketImage: "FalconTestPng")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rockets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",  for: indexPath) as! RocketViewCell
        
        cell.layer.borderWidth = 2.0
        
       // cell.textLabel?.text = "falcon"
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

