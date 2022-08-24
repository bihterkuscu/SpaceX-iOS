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
import Firebase

class DetailsViewController: UIViewController {
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      return  detailsData.flickr_images.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell  = tableView.dequeueReusableCell(withIdentifier: "galleryCell", for: indexPath) as! GalleryTableViewCell
////        let rocketsViewModel = self.rocketsTableViewModel.rocketsAtIndexPath(indexPath.row)
//        cell.gallery.loadss(urlString: detailsData.flickr_images[indexPath.row])
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 115
//    }
//    private var rocketsTableViewModel: RocketsTableViewModel!
    
    let glideshow = Glideshow()
//
//    @IBOutlet weak var galleryTable: UITableView!
    
    @IBOutlet weak var rocketImg: UIImageView!

    @IBOutlet weak var detailsFavButton: UIButton!
    
    @IBOutlet weak var rocketDetail: UILabel!
    @IBOutlet weak var rocketType: UILabel!
    @IBOutlet weak var rocketName: UILabel!
    
    let db = Firestore.firestore()

    @IBAction func detailsFavClicked(_ sender: UIButton) {
        
        let ref = self.db.collection(FavoritesDB.collectionName).document(Auth.auth().currentUser!.uid)

        let rocketId = self.detailsData.id
        ref.getDocument { querySnapshot, error in
            var fav = true;
            if(querySnapshot?.data() != nil && (querySnapshot?.data()?[rocketId]) != nil){
                let rocketData = querySnapshot!.data()![rocketId]! as! Dictionary<String,AnyObject>
                
                if((rocketData[FavoritesDB.favorite]!) as! Bool==true){
                    fav=false
                }
            }
            
            ref.setData([
                rocketId : [
                        FavoritesDB.favorite : fav
                    ]], merge: true)
            
            var star="barsTabBarElementsItemsStar"
                if(fav==true){
                    star = "barsTabBarElementsItemsActivePressedStar"
                }
                sender.setImage(UIImage(named: star), for: .normal)
            }
    }
    
    var detailsData :RocketData = RocketData(flickr_images: ["",""], description: "", id: "", name: "", type: "")
    
    var isFav = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        let nib = UINib(nibName: "GalleryTableViewCell", bundle: nil)
//        galleryTable.register(nib, forCellReuseIdentifier: "galleryCell")
//        galleryTable.dataSource = self
//        galleryTable.delegate = self
//
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "spaceXIOsBg")!)
        
        self.rocketName.text=detailsData.name
        self.rocketDetail.text=detailsData.description
        self.rocketType.text=detailsData.type
        self.rocketImg.load(urlString: detailsData.flickr_images[0])
       
        
        self.detailsFavButton.setImage(UIImage(named: getFavImage()), for: .normal)
        
 

    }
    
    private func getFavImage()-> String{
        var star="barsTabBarElementsItemsStar"
        if(self.isFav==true){
                star = "barsTabBarElementsItemsActivePressedStar"
            }
        return star
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        glideshow.frame = CGRect(x: 0, y: 600, width:self.view.frame.width, height: 230)

    }
    private func setupUI(){
        var images : [GlideItem] = []
        view.backgroundColor = .white
        
        self.detailsData.flickr_images.forEach { image in
            var glideItem : GlideItem = GlideItem(imageURL:image)
            images.append(glideItem)
        }
        glideshow.items = images



   
            
//        for rocket in detailsData.flickr_images{
//            glideshow.items = [GlideItem(imageURL: rocket)]
//        }
//
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
