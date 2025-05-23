//
//  User.swift
//  Hunger
//
//  Created by Roman Reimche on 24.09.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import Foundation
import CoreLocation

// fbUID = FirebaseUid
typealias FbUid = String

// TODO Differentiate between score as a zombie and as a human
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
    
    var uid: FbUid
    var email: String?
    var displayName: String?
    var location: CLLocation?
    var playsAs : PlayAs?
    var score: Int?

    init(uid: String, displayName: String?, email: String?, location: CLLocation? = nil, playsAs: PlayAs? = nil, score: Int? = nil) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.location = location
        self.playsAs = playsAs
        self.score = score
    }

}
