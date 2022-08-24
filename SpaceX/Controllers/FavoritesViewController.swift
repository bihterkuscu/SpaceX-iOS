//
//  FavoritesViewController.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 24.08.2022.
//

import UIKit
import Firebase

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var favTableView: UITableView!
    
    let db = Firestore.firestore()
    
    private var favorites : [String]! = []
    private var rocketsTableViewModel: RocketsTableViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: K.cellNibName, bundle: nil)
        favTableView.register(nib, forCellReuseIdentifier: K.cellIdentifier)
        favTableView.dataSource = self
        favTableView.delegate = self
        favTableView.backgroundView = UIImageView(image: UIImage(named: "spaceXIOsBg"))
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    func getData() {
        let url = URL(string: "https://api.spacexdata.com/v4/rockets")
        RocketManager().downloadRockets(url: url!) { (rockets) in
            if let rockets = rockets {
                self.rocketsTableViewModel = RocketsTableViewModel(rocketList: rockets)
               
                DispatchQueue.main.async {
                    self.favTableView.reloadData()
                }
            }
        }
    }
    
    // TODO: veri tabanından kaydı çekerken sorguya favorite alanı 1 olanları getir dememiz lazım.
    func getFavorites(){
        self.favorites = []
        let ref = self.db.collection(FavoritesDB.collectionName).document(Auth.auth().currentUser!.uid)
        
        ref.getDocument(){ (querySnapshot,err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    } else {
                        var datas = querySnapshot?.data()!
                        
                        datas?.forEach({ (key: String, value: Any) in
                            let rocketD = value as! NSDictionary
                                if((rocketD[FavoritesDB.favorite]!) as! Bool==true){
                                    self.favorites.append(key as! String)
                                    
                                }
                        })
                        
                    }
                        DispatchQueue.main.async {
                            self.favTableView.reloadData()
                        }
                }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.favorites == nil ? 0 : self.favorites.count
    }
    
    @objc func didTapCellButton(sender: UIButton) {
        
        let indexPath = sender.tag
        let rocketId = self.favorites[indexPath]
        let ref = self.db.collection(FavoritesDB.collectionName).document(Auth.auth().currentUser!.uid)
            ref.setData([
                rocketId : [
                        FavoritesDB.favorite : false
                    ]], merge: true)
            
                    // TODO: satırı sil
     
        self.favorites.remove(at: indexPath)
                DispatchQueue.main.async {
                    self.favTableView.reloadData()
                }

            }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell  = tableView.dequeueReusableCell(withIdentifier: "rocketcell", for: indexPath) as! RocketViewCell
        let rocketList = rocketsTableViewModel.rocketList
        let rocketData :(RocketData) = rocketList.first{$0.id == self.favorites![indexPath.row]}!
    
        cell.rocketName.text = rocketData.name
        cell.rocketImage.load(urlString: rocketData.flickr_images[0])
        cell.favoriteButton.addTarget(self, action: #selector(didTapCellButton(sender:)), for: .touchUpInside)
        cell.favoriteButton.setImage(UIImage(named: "barsTabBarElementsItemsActivePressedStar"), for: .normal)
        cell.favoriteButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 299
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rocketList = rocketsTableViewModel.rocketList
        let rocketData :(RocketData) = rocketList.first{$0.id == self.favorites![indexPath.row]}!
        let dc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        dc.detailsData=rocketData
        dc.isFav=true
        self.navigationController?.pushViewController(dc, animated: true)
    }
    

}
