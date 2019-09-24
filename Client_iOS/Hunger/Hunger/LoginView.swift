//
//  LoginView.swift
//  Hunger
//
//  Created by Roman Reimche on 24.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI
import Crashlytics

struct LoginView: View {
    
    @State private var email : String = ""
    @State private var password : String = ""
    @State var loading = false
    @State var error = false
    
    @EnvironmentObject var session : SessionStore
    
    func logIn () {
        loading = true
        error = false
        session.signIn(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    func signUp () {
        loading = true
        error = false
        session.signUp(email: email, password: password) { (result, error) in
            self.loading = false
            if error != nil {
                self.error = true
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    func crash(){
        Crashlytics.sharedInstance().crash()
    }
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button(action: logIn){ Text("Log In") }
                Button(action: signUp){ Text("Sign Up")}
                if error { Text("Something's wrong") }

                Button(action: crash){Text("Crash")}
            }
            .navigationBarTitle("Log In")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
