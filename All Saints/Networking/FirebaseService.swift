//
//  FirebaseService.swift
//  All Saints
//
//  Created by ilyar on 10/2/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import Foundation
import FirebaseDatabase

let ref = Database.database().reference()

class FirebaseService {
    static func setNewScore(id: String, name: String, score: Double) {
        ref.child("players").setValue(["id": id,
                                       "name": name,
                                       "score": score
        ])
    }
    
//    static func getAllPlayers() -> Player {
//        return Player()
//    }
}
