//
//  LoginView.swift
//  Hunger
//
//  Created by Roman Reimche on 24.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var email : String = ""
    @State private var password : String = ""
    
    var body: some View {
        NavigationView{
            Form {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button(action: {}, label: {Text("go")})
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
