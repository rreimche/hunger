//
//  SessionStorage.swift
//  Hunger
//
//  Created by Roman Reimche on 24.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import Foundation

import SwiftUI
import Firebase
import Combine

class SessionStore : ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?

    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = User(
                    uid: user.uid,
                    displayName: user.displayName,
                    email: user.email
                )
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }

    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        
        
        //TODO use the given handler if it is given
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            let user = authResult!.user
            print("AuthResult: \(String(describing: authResult))")
            print("User: \(String(describing: user.email))")
            print("Error: \(String(describing: error))")
            
        }
    }

    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        //TODO use the given handler if it is given
        Auth.auth().signIn(withEmail: email, password: password){ [weak self] authResult, error in
            guard let strongSelf = self else { return }
            let user = authResult!.user
            print("AuthResult: \(String(describing: authResult))")
            print("User: \(String(describing: user.email))")
            print("Error: \(String(describing: error))")
        }
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        } catch {
            return false
        }
    }
    
    func unbind () {
       if let handle = handle {
           Auth.auth().removeStateDidChangeListener(handle)
       }
    }
}
