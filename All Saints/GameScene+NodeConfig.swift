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
    static let player : UInt32 = 0
    static let beer: UInt32 = 1
    static let milk: UInt32 = 2
    static let corner: UInt32 = 3
}

enum RowType: Int{
    case one, two, three, four, five, six
}

extension GameScene {
    
    func setupWorldPhysics() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }
    
    func moveBackground(){
        let move = SKAction.moveBy(x: 0, y: -screenHeight, duration: 5)
        let replace = SKAction.moveBy(x: 0, y: screenHeight, duration: 0)
        let moveForever = SKAction.repeatForever(SKAction.sequence([move,replace]))
        for i in 0...3 {
            background = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "GameWall")))
            background.size = CGSize(width: screenWidth, height: screenHeight)
            background.position = CGPoint(x: screenWidth / 2 , y: screenHeight * CGFloat(i))
            background.run(moveForever)
            background.zPosition = -1
            addChild(background)
        }
    }
    
    func createWall() -> SKSpriteNode {
        var textures = [SKTexture]()
        textures.append(SKTexture(image: #imageLiteral(resourceName: "milk")))
        textures.append(SKTexture(image: #imageLiteral(resourceName: "beer")))
        let rand = Int(arc4random_uniform(UInt32(textures.count)))
        let texture = textures[rand] as SKTexture
        
        let   wall = SKSpriteNode(texture: texture)
        wall.name = "wall"
        wall.position = CGPoint(x: 0, y: screenHeight / 0.78)
        wall.zPosition = 1
        wall.size = CGSize(width: 80, height: 80)
        wall.physicsBody?.isDynamic = false
        wall.physicsBody = SKPhysicsBody(circleOfRadius: screenHeight / 33.35)
//        wall.physicsBody?.categoryBitMask = bitMask.wall
        wall.physicsBody?.collisionBitMask = 0
        
//        let rotate = SKAction.rotate(byAngle: .pi / 4, duration: 1)
//        let foreverRotate = SKAction.repeatForever(rotate)
//        wall.run(foreverRotate)
        return wall
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
