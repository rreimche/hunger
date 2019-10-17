//
//  PlayAsHumanView.swift
//  Hunger
//
//  Created by Roman Reimche on 27.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import SwiftUI

struct PlayAsHumanView: View {
    @EnvironmentObject var session : SessionStore
    var body: some View {
        GameView(locationManager: LocationManager(session: self.session))
    }
}

struct PlayAsHumanView_Previews: PreviewProvider {
    static var previews: some View {
        PlayAsHumanView()
    }
}
