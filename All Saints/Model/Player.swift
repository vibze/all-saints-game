//
//  Player.swift
//  All Saints
//
//  Created by ilyar on 10/2/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Player {
    let ref: DatabaseReference?
    let id: String
    let name: String
    let score: Double
    
    init(id: String, name: String, score: Double) {
        self.ref = nil
        self.id = id
        self.name = name
        self.score = score
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let id = value["id"] as? String,
            let score = value["score"] as? Double
        else { return nil }
        
        self.ref = snapshot.ref
        self.id = id
        self.name = name
        self.score = score
    }
    
    func toAnyObject() -> Any {
        return [
            "id": id,
            "name": name,
            "score": score
        ]
    }
}

