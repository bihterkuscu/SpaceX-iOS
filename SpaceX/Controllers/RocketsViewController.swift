//
//  ViewController.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 8.08.2022.
//
import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

class RocketsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()

       private var rocketsTableViewModel: RocketsTableViewModel!
    
        private var favorites : NSDictionary!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: K.cellNibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: K.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "spaceXIOsBg"))
        getData()
        //getFavorities()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorities()
    }
    
    func getData() {
        let url = URL(string: "https://api.spacexdata.com/v4/rockets")
        RocketManager().downloadRockets(url: url!) { (rockets) in
            if let rockets = rockets {
                self.rocketsTableViewModel = RocketsTableViewModel(rocketList: rockets)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    func getFavorities(){
        let ref = self.db.collection(FavoritesDB.collectionName).document(Auth.auth().currentUser!.uid)

        ref.getDocument(){
                (querySnapshot,err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    } else {
                        self.favorites = querySnapshot?.data()! as NSDictionary?
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }

                    }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rocketsTableViewModel == nil ? 0 : self.rocketsTableViewModel.numberOfRowsInSection()
    }
    
    @objc func didTapCellButton(sender: UIButton) {
        
        let indexPath = sender.tag
        let rocket :RocketData = rocketsTableViewModel.rocketList[indexPath]
        let ref = self.db.collection(FavoritesDB.collectionName).document(Auth.auth().currentUser!.uid)

        ref.getDocument { querySnapshot, error in
            var fav = true;
            if(querySnapshot?.data() != nil && (querySnapshot?.data()?[rocket.id]) != nil){
                let rocketData = querySnapshot!.data()![rocket.id]! as! Dictionary<String,AnyObject>
                
                if((rocketData[FavoritesDB.favorite]!) as! Bool==true){
                    fav=false
                }
            }
            
            ref.setData([
                    rocket.id : [
                        FavoritesDB.favorite : fav
                    ]], merge: true)
            
            var star="barsTabBarElementsItemsStar"
                if(fav==true){
                    star = "barsTabBarElementsItemsActivePressedStar"
                }
                sender.setImage(UIImage(named: star), for: .normal)
            }
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "rocketcell", for: indexPath) as! RocketViewCell
        let rocketsViewModel = self.rocketsTableViewModel.rocketsAtIndexPath(indexPath.row)
        cell.rocketName.text = rocketsViewModel.rocketsName
        cell.rocketImage.load(urlString: rocketsViewModel.rocketsImage[0])
        cell.favoriteButton.addTarget(self, action: #selector(didTapCellButton(sender:)), for: .touchUpInside)
            
        var star="barsTabBarElementsItemsStar"
           
        
        if(self.favorites?[rocketsViewModel.rocketId] != nil){
            let rocketD = self.favorites?[rocketsViewModel.rocketId]! as! Dictionary<String,AnyObject>
            if((rocketD[FavoritesDB.favorite]!) as! Bool==true){
                 star = "barsTabBarElementsItemsActivePressedStar"
             }
        }
        
        cell.favoriteButton.setImage(UIImage(named: star), for: .normal)

        cell.favoriteButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 299
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rocketsViewModel = self.rocketsTableViewModel.rocketsAtIndexPath(indexPath.row)
        let dc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        dc.detailsData=rocketsViewModel.rockets
        if(self.favorites?[rocketsViewModel.rocketId] != nil){
            let rocketD = self.favorites?[rocketsViewModel.rocketId]! as! Dictionary<String,AnyObject>
            if((rocketD[FavoritesDB.favorite]!) as! Bool==true){
                dc.isFav=true
             }
        }
        self.navigationController?.pushViewController(dc, animated: true)
    }
}

