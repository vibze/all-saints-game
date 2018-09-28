//
//  Ship.swift
//  All Saints
//
//  Created by admin on 9/28/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import SpriteKit


class Ship: SKSpriteNode {
    
    static func construct(size: CGSize) -> Ship {
        let ship = Ship(texture: SKTexture(image: #imageLiteral(resourceName: "Rocket")))
        ship.name = "player"
        ship.size = size
        ship.zPosition = 1
        ship.speed = 10
        ship.physicsBody?.isDynamic = true
        ship.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width - 20, height: size.height - 5))
        ship.physicsBody?.categoryBitMask = bitMask.player
        ship.physicsBody?.collisionBitMask = bitMask.player
        ship.physicsBody?.contactTestBitMask = bitMask.wall
        
        ship.burnerEmitter.position = CGPoint(x: 0, y: -50)
        ship.burnerEmitter.zPosition = 1
        ship.burnerEmitter.isHidden = true
        ship.addChild(ship.burnerEmitter)
        
        return ship
    }
    
    let burnerEmitter = SKEmitterNode(fileNamed: "spark.sks")!
    
    func ignite() {
        burnerEmitter.isHidden = false
    }

    func setRandomPhoto() {
        
    }
}
