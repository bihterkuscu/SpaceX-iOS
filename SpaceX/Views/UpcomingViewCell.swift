//
//  UpcomingViewCell.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 19.08.2022.
//

import UIKit

class UpcomingViewCell: UITableViewCell {

    @IBOutlet weak var upcomingCellName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

var imageList2 = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func loads(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
