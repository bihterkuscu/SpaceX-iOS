//
//  DetailsViewController.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 16.08.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var rocketImg: UIImageView!

    @IBOutlet weak var rocketDetail: UILabel!
    @IBOutlet weak var rocketType: UILabel!
    @IBOutlet weak var rocketName: UILabel!
    
    var detailsData :RocketData = RocketData(flickr_images: ["",""], description: "", id: "", name: "", type: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "spaceXIOsBg")!)
        
        self.rocketName.text=detailsData.name
        self.rocketDetail.text=detailsData.description
        self.rocketType.text=detailsData.type
        self.rocketImg.load(urlString: detailsData.flickr_images[0])
    }
}
