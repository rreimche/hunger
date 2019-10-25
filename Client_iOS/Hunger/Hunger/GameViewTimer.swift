//
//  GameViewTimer.swift
//  Hunger
//
//  Created by Roman Reimche on 25.10.19.
//  Copyright © 2019 Roman Reimche. All rights reserved.
//

import Foundation

class GameViewTimer {
    private var timer: Timer?
    var target: GameView?
    
    func startTimer(timeInterval: TimeInterval, withBlock block: @escaping (Timer) -> Void){
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: block)
    }
    
}
