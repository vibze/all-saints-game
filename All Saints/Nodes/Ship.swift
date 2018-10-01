//
//  Ship.swift
//  All Saints
//
//  Created by admin on 9/28/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import SpriteKit


class Ship: SKSpriteNode {
    
    static func construct() -> Ship {
        let ship = Ship(texture: SKTexture(image: #imageLiteral(resourceName: "Rocket")))
        ship.name = "player"
        ship.size = CGSize(width: 110, height: 170)
        ship.zPosition = 1
        ship.speed = 10
        ship.physicsBody?.isDynamic = true
        ship.physicsBody?.usesPreciseCollisionDetection = true
        ship.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ship.size.width - 50, height: ship.size.height / 2))
        ship.physicsBody?.categoryBitMask = bitMask.player
        ship.physicsBody?.collisionBitMask = bitMask.player
        ship.physicsBody?.contactTestBitMask = bitMask.beer & bitMask.milk & bitMask.corner
        
        ship.burnerEmitter.position = CGPoint(x: 0, y: -90)
        ship.burnerEmitter.zPosition = 1
        ship.burnerEmitter.isHidden = true
        ship.addChild(ship.burnerEmitter)
        
        ship.addChild(ship.photoNode)
        ship.photoNode.size = CGSize(width: 50, height: 50)
        ship.photoNode.position = CGPoint(x: 0, y: 15)
        ship.setRandomPhoto()
        
        return ship
    }
    
    let burnerEmitter = SKEmitterNode(fileNamed: "spark.sks")!
    let photoNode = SKSpriteNode()
    
    
    func ignite() {
        burnerEmitter.isHidden = false
    }

    func setRandomPhoto() {
        let i = Int.random(in: 1 ... 7)
        photoNode.texture = SKTexture(imageNamed: "lex-\(i)")
        photoNode.zPosition = 1
    }
}
