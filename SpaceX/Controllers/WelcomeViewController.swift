//
//  WelcomeViewController.swift
//  SpaceX
//
//  Created by Elif Bihter Kuşçu on 18.08.2022.
//

import UIKit
import Firebase
class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: K.welcometologin, sender: self)
        }
    }
}
