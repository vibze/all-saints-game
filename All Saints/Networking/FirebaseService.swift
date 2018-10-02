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
    static func setNewScore(player: Player) {
        ref.child(player.id).setValue(player.toAnyObject())
    }
    
    static func getAllPlayers(completion: @escaping ([Player]) -> ()) {
        ref.observe(.value) { (snapshot) in
            var players = [Player]()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let player = Player(snapshot: snapshot) {
                    players.append(player)
                }
            }
            players.sort(by: { (lPlayer, rPlayer) -> Bool in
                lPlayer.score > rPlayer.score
            })
            completion(players)
        }
    }
}
