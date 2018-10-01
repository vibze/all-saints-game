//
//  Elements.swift
//  space
//
//  Created by Kamila Kusainova on 26.06.17.
//  Copyright © 2017 sdu. All rights reserved.
//

import Foundation
import SpriteKit


struct bitMask {
    static let player : UInt32 = 1
    static let beer: UInt32 = 2
    static let milk: UInt32 = 3
    static let corner: UInt32 = 4
}

extension GameScene {
    
    func setupWorldPhysics() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    func moveBackground() {
        let move = SKAction.moveBy(x: 0, y: -screenHeight, duration: 5)
        let replace = SKAction.moveBy(x: 0, y: screenHeight, duration: 0)
        let moveForever = SKAction.repeatForever(SKAction.sequence([move,replace]))
        for i in 0...3 {
            background = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "backgroundImage")))
            background.aspectFillToSize(fillSize: frame.size)
            background.position = CGPoint(x: frame.size.width / 2 , y: frame.size.height * CGFloat(i))
            background.run(moveForever)
            background.zPosition = -1
            addChild(background)
        }
    }
    
    func addMovement(wall :SKSpriteNode){
        if state == .play{
            var actionArray = [SKAction]()
            actionArray.append(SKAction.move(to: CGPoint(x: wall.position.x, y: -wall.size.height), duration: TimeInterval(i)))
            actionArray.append(SKAction.removeFromParent())
            wall.run(SKAction.sequence(actionArray))
        }
        if i <= 0 {
            state = .end
        }
    }
    
    func addTutorial(){
        let toRight = SKAction.moveBy(x: screenWidth, y: 0, duration: 2.0)
        let toLeft = SKAction.moveBy(x: -screenWidth, y: 0, duration: 2.0)
        let repeatForever = SKAction.repeatForever(SKAction.sequence([toRight,toLeft]))
        swipeSprite = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "finger-swipe")))
        swipeSprite.size = CGSize(width: screenWidth / 5, height: screenHeight / 8.9)
        swipeSprite.position = CGPoint(x: 0, y: 70)
        swipeSprite.isHidden = false
        swipeSprite.run(repeatForever)
        addChild(swipeSprite)
    }
    
    func removeTutorial() {
        swipeSprite.removeAllActions()
        swipeSprite.removeFromParent()
    }
}
