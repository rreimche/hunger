//
//  PlayAsZombieView.swift
//  Hunger
//
//  Created by Roman Reimche on 27.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI

struct PlayAsZombieView: View {
    @EnvironmentObject var session : SessionStore
    var body: some View {
        GameView()
    }
}

struct PlayAsZombieView_Previews: PreviewProvider {
    static var previews: some View {
        PlayAsZombieView()
    }
}
