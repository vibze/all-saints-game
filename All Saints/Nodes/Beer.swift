//
//  Beer.swift
//  All Saints
//
//  Created by admin on 9/28/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import SpriteKit


class BeerNode: SKSpriteNode {
    static func construct() -> BeerNode {
        let beer = BeerNode(texture: SKTexture(image: #imageLiteral(resourceName: "beer")))
        beer.name = "beer"
        beer.size = CGSize(width: 90, height: 100)
        beer.zPosition = 1
        beer.zRotation = 0
        beer.physicsBody?.isDynamic = true
        beer.physicsBody?.usesPreciseCollisionDetection = true
        beer.physicsBody?.allowsRotation = false
        beer.physicsBody = SKPhysicsBody(rectangleOf: beer.size)
        beer.physicsBody?.categoryBitMask = bitMask.beer
        beer.physicsBody?.collisionBitMask = bitMask.beer
        beer.physicsBody?.contactTestBitMask = bitMask.player

        return beer
    }
}
