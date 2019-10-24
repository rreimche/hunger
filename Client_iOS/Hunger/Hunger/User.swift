//
//  User.swift
//  Hunger
//
//  Created by Roman Reimche on 24.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import Foundation
import CoreLocation

struct User: Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        
        return lhs.uid == rhs.uid
//            && lhs.email == rhs.email
//            && lhs.displayName == rhs.displayName
//            && lhs.location == rhs.location
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(self.uid)
    }
    
    var uid: String
    var email: String?
    var displayName: String?
    var location: CLLocation?
    var playsAs : PlayAs?

    init(uid: String, displayName: String?, email: String?, location: CLLocation? = nil, playsAs: PlayAs? = nil) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.location = location
        self.playsAs = playsAs
    }

}
