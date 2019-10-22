//
//  MarkerIconView.swift
//  Hunger
//
//  Created by Roman Reimche on 22.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI

struct MarkerIconView: View {
    let iconFor: PlayAs
    
    //@ViewBuilder
    var body: some View {
        Text("👩🏻‍💼")
        /*switch iconFor {
        case .human: Text("👩🏻‍💼")
        case .zombie: Text("🧟‍♀️")
        }*/
    }
}

struct MarkerIconView_Previews: PreviewProvider {
    static var previews: some View {
        MarkerIconView(iconFor: .human)
    }
}
