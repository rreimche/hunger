//
//  SignInView.swift
//  Hunger
//
//  Created by Roman Reimche on 24.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI
import Crashlytics

struct SignInView: View {
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State var loading = false
    @State var error : Error? = nil
    
    @EnvironmentObject var session : SessionStore
    
    
    func signIn () {
        loading = true
        error = nil
        session.signIn(email: email, password: password) { authResult, error -> () in
            self.loading = false
            if error == nil {
                
                let user = self.session.user
                self.email = ""
                self.password = ""
                
                print("AuthResult: \(String(describing: authResult))")
                print("User: \(String(describing: user!.email))")
                print("Error: \(String(describing: error))")
                
            } else {
                self.error = error
            }
            
        }
    }
    
    func signUp () {
        loading = true
        error = nil
        session.signUp(email: email, password: password) { authResult, error -> () in
            self.loading = false
            if error == nil {
                
                let user = self.session.user
                self.email = ""
                self.password = ""
                
                print("AuthResult: \(String(describing: authResult))")
                print("User: \(String(describing: user!.email))")
                print("Error: \(String(describing: error))")
                
            } else {
                self.error = error
            }
            
        }
    }
    
    func crash(){
        Crashlytics.sharedInstance().crash()
    }
    
    
    
    var body: some View {
        NavigationView{
            Form {
                //TODO use error codes to adequately react to errors
                if error != nil {
                    Text("Error: \(error!.localizedDescription)")
                        .foregroundColor(.red)
                    
                }
                
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button(action: signIn){ Text("Log In") }
                Button(action: signUp){ Text("Sign Up")}

                Button(action: crash){ Text("Crash") }
            }
            .navigationBarTitle("Welcome!")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
