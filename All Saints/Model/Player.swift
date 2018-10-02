//
//  Player.swift
//  All Saints
//
//  Created by ilyar on 10/2/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Parsable {
    init?(from json: JSON)
}

struct Player: Parsable {
    let id: String
    let name: String
    let score: Double
    
    init?(from json: JSON) {
        guard
            let id = json["id"].string,
            let name = json["name"].string,
            let score = json["score"].double
        else { return nil }
        
        self.id = id
        self.name = name
        self.score = score
    }
}

