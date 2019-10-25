//
//  GameOverView.swift
//  Hunger
//
//  Created by Roman Reimche on 22.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI

struct GameOverView: View {
    var body: some View {
            VStack{
                Text("🧟‍♂️🧟‍♂️🧟‍♂️").font(.largeTitle) 
                Text("Zombies ate your brains!")
                Text("Gave Over.")
            }
        
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
    }
}
