//
//  RocketViewCell.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 9.08.2022.
//

import UIKit

class RocketViewCell: UITableViewCell {

    @IBOutlet weak var rocketImage: UIImageView!
    @IBOutlet weak var rocketName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
