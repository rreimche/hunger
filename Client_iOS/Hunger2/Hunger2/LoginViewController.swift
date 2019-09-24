//
//  ViewController.swift
//  Hunger2
//
//  Created by Roman Reimche on 24.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    //private var handle : AuthStateDidChangeListenerHandle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
//            if let user = user {
//                // if we have a user, create a new user model
//                print("Got user: \(user)")
////                self.session = User(
////                    uid: user.uid,
////                    displayName: user.displayName,
////                    email: user.email
////                )
//            } else {
//                // if we don't have a user, set our session to nil
////                self.session = nil
//                print("Have a problem")
//            }
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Auth.auth().removeStateDidChangeListener(handle)
    }

    @IBAction func logIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            let user = authResult!.user
            print("AuthResult: \(String(describing: authResult))")
            print("User: \(String(describing: user.email))")
            print("Error: \(String(describing: error))")
        }
        // TODO performSegue only if logOut was successful
        self.performSegue(withIdentifier: "ShowMainMenuSegue", sender: sender)
        
    }
    
    @IBAction func signIn(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.email.text!, password: self.password.text!) { authResult, error in
            let user = authResult!.user
            print("AuthResult: \(String(describing: authResult))")
            print("User: \(String(describing: user.email))")
            print("Error: \(String(describing: error))")
            
        }
        
        //TODO performSegue only if signIn Successful
        performSegue(withIdentifier: "ShowMainMenuSegue", sender: sender)
    }
}

