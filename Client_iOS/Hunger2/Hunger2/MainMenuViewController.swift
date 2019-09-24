//
//  MainMenuViewController.swift
//  Hunger2
//
//  Created by Roman Reimche on 24.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import UIKit
import Firebase

class MainMenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func logOut(_ sender: Any) {
        if let result = try? Auth.auth().signOut() {
            print("Logged out: \(result)")
        } else {
            print("Something went wrong at log out")
        }
        performSegue(withIdentifier: "ShowLogInViewSegue", sender: sender)
        
    }
}
