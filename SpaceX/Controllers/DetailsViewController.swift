//
//  DetailsViewController.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 16.08.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var rocketImg: UIImageView!
    @IBOutlet weak var slideGallery: UICollectionView!
    @IBOutlet weak var rocketDetail: UILabel!
    
    
    var details: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        rocketDetail.text = details

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
