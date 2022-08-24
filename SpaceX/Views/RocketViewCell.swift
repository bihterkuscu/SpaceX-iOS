//
//  RocketViewCell.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 16.08.2022.
//

import UIKit

protocol RocketViewCellProtocol {
 func didSelect(cell: RocketViewCell)
}

final class RocketViewCell: UITableViewCell {
    
     var delegate : RocketViewCellProtocol?
    
    //var closure: (()->())?
    @IBOutlet weak var rocketImage: UIImageView!
    @IBOutlet weak var rocketName: UILabel!

    @IBOutlet weak var favoriteButton: UIButton!
//    @IBAction func favButtonAction(_ sender: UIButton) {
//
    //closure?()
//    }
    override func awakeFromNib() {
        
        super.awakeFromNib()
        let image = UIImage(named: "barsTabBarElementsItemsStar")
        let imageFilled = UIImage(named: "barsTabBarElementsItemsActivePressedStar")
        favoriteButton.setImage(image, for: .normal)
        favoriteButton.setImage(imageFilled, for: .selected)

    }

//    @IBAction func didTapButton(sender: UIButton) {
//        delegate?.didSelect(cell: self)
//        }


    @IBAction func favButtonAction(_ sender: UIButton) {
        
        guard let cell = (sender as AnyObject).superview?.superview as? RocketViewCell else {
                return // or fatalError() or whatever
            }

        self.delegate!.didSelect(cell: cell)
            favoriteButton.isSelected.toggle()
        }
    }
    
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
      // Configure the view for the selected state
//    }
//}
var imageList = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    func load(urlString: String) {
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



