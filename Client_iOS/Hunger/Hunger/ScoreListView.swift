//
//  ScoreListView.swift
//  Hunger
//
//  Created by Roman Reimche on 27.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI

struct ScoreListView: View {
    
    
    var body: some View {
        List {
            HStack{
                Text("Username1")
                Spacer()
                Text("1000")
            }
            
            HStack{
                Text("Username2")
                Spacer()
                Text("1000")
            }
            
            HStack{
                Text("Username3")
                Spacer()
                Text("1000")
            }
            HStack{
                Text("Username4")
                Spacer()
                Text("1000")
            }
            HStack{
                Text("Username5")
                Spacer()
                Text("1000")
            }
        }
    }
}

struct ScoreListView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreListView()
    }
}
