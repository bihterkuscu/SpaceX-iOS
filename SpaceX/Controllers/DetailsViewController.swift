//
//  DetailsViewController.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 16.08.2022.
//

import UIKit
import ImageSlideshow
import Alamofire
import AlamofireImage
import Glideshow

class DetailsViewController: UIViewController {

    let glideshow = Glideshow()
    
    
    @IBOutlet weak var rocketImg: UIImageView!

    @IBOutlet weak var rocketDetail: UILabel!
    @IBOutlet weak var rocketType: UILabel!
    @IBOutlet weak var rocketName: UILabel!
    
    var detailsData :RocketData = RocketData(flickr_images: ["",""], description: "", id: "", name: "", type: "")
    
    var isFav = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "spaceXIOsBg")!)
        
        self.rocketName.text=detailsData.name
        self.rocketDetail.text=detailsData.description
        self.rocketType.text=detailsData.type
        self.rocketImg.load(urlString: detailsData.flickr_images[0])
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        glideshow.frame = CGRect(x: 0, y: 600, width:self.view.frame.width, height: 230)
       
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        
        glideshow.items = [
            GlideItem(imageURL: "https://imgur.com/DaCfMsj.jpg"),
            GlideItem(imageURL: "https://imgur.com/azYafd8.jpg"),
            
            GlideItem(imageURL: "https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg"),
            GlideItem(imageURL: "https://farm4.staticflickr.com/3955/32915197674_eee74d81bb_b.jpg"),
            GlideItem(imageURL: "https://farm1.staticflickr.com/293/32312415025_6841e30bf1_b.jpg") ]
        
        
        glideshow.delegate = self
        glideshow.isCircular = true
        
        glideshow.gradientColor =
            UIColor.black.withAlphaComponent(0.8)
    
        glideshow.gradientHeightFactor = 0.8
        glideshow.pageIndicatorPosition = .bottom
        glideshow.interval = 5
        
       
        view.addSubview(glideshow)
        
    }
    

}

extension DetailsViewController : GlideshowProtocol {
    func glideshowDidSelecteRowAt(indexPath: IndexPath, _ glideshow: Glideshow) {
        print(indexPath)
    }
    
    func pageDidChange(_ glideshow: Glideshow, didChangePageTo page: Int) {
        
    }
}

