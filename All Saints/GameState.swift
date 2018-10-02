//
//  GameState.swift
//  space
//
//  Created by Kamila Kusainova on 28.06.17.
//  Copyright © 2017 sdu. All rights reserved.
//

import Foundation

enum GameState {
    case tutorial, play, pause, end
}

class Model {
    
    static let sharedInstance = Model()
    var sound = true
}
