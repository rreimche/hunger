//
//  PlayAs.swift
//  Hunger
//
//  Created by Roman Reimche on 22.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import Foundation


enum PlayAs: String { 
    
    case human
    case zombie
    
}

extension PlayAs {
    init?(playerType: String) throws {
        switch playerType{
        case "human": self = .human
        case "zombie": self = .zombie
        default: throw PlayAsError.invalidPlayerType(type: playerType)
        }
    }
}

enum PlayAsError: Error {
    case invalidPlayerType(type: String)
}
