//
//  HallOfFameView.swift
//  Hunger
//
//  Created by Roman Reimche on 27.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI

struct HallOfFameView: View {
    
    var body: some View {
        TabView {
            ScoreListView()
                .tabItem{Text("Total achievement (H&Z)")}
            
            ScoreListView()
                .tabItem{Text("As Human")}
            
            ScoreListView()
                .tabItem{Text("As Zombie")}
        }
    }
}

struct HallOfFameView_Previews: PreviewProvider {
    static var previews: some View {
        HallOfFameView()
    }
}
