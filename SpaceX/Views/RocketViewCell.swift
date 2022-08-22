//
//  RocketViewCell.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 16.08.2022.
//

import UIKit

class RocketViewCell: UITableViewCell {

    @IBOutlet weak var rocketImage: UIImageView!
    @IBOutlet weak var rocketName: UILabel!
   
    @IBOutlet weak var favButton: UIButton!
    @IBAction func favButtonn(_ sender: UIButton) {
        
//        if let fav = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
//            db.collection(K.FStore.collectionName).addDocument(data: [
//                K.FStore.senderField: messageSender,
//                K.FStore.bodyField: messageBody,
//                K.FStore.dateField: Date().timeIntervalSince1970
//            ]) { (error) in
//                if let e = error {
//                    print("There was an issue saving data to firestore, \(e)")
//                } else {
//                    print("Successfully saved data.")
//
//                    DispatchQueue.main.async {
//                         self.messageTextfield.text = ""
//                    }
//                }
//            }
//        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
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
