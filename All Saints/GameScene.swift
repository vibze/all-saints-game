//
//  GameScene.swift
//  space
//
//  Created by Kamila Kusainova on 26.06.17.
//  Copyright © 2017 sdu. All rights reserved.
//

import SpriteKit
import GameplayKit


protocol GameSceneDelegate: class {
    func gameScene(_ gameScene: GameScene, scoreDidChange score: Int)
    func didStartGame(_ gameScene: GameScene)
}

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var state = GameState.tutorial {
        didSet {
            stateChanged(to: state)
        }
    }
    
    weak var sceneDelegate: GameSceneDelegate?
    
    let ship = Ship.construct()
    var beerSpeed = 3.5
    var shipSpeed = 5.0 {
        didSet {

        }
    }
    
    var background: SKSpriteNode!
    var boomEmitter:SKEmitterNode!
    var swipeSprite: SKSpriteNode!
    var move = SKAction()

    // Touch handling
    var i: Float = 5
    var backgroundMusic = SKAudioNode()
    var drinkMusic = SKAudioNode()

    // MARK: - Did move to skVIew
    override func didMove(to view: SKView) {
        ship.position = CGPoint(x: view.frame.width/2, y: view.frame.width - ship.size.height - 40)
        addChild(ship)
        
        backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1607843137, blue: 0.06274509804, alpha: 1)
        setupWorldPhysics()
        moveBackground()

        if let url = Bundle.main.url(forResource: "gulp-1", withExtension: "mp3") {
            drinkMusic = SKAudioNode(url: url)
            drinkMusic.autoplayLooped = false
            drinkMusic.run(SKAction.stop())
            addChild(drinkMusic)
        }
       
        if let url = Bundle.main.url(forResource: "soundtrack", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: url)
            backgroundMusic.run(SKAction.stop())
            addChild(backgroundMusic)
        }
        
        state = .tutorial
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        ship.ignite()
        guard contact.bodyA.node?.name == "player" else {
            return
        }
        ship.showBubbles()
        score += 1
        contact.bodyB.node?.removeFromParent()
        ship.photoTransform()
        if Model.sharedInstance.sound {
            drinkMusic.run(SKAction.play())
        }
    }
    
    var shipInitialX: CGFloat = 0
    var touchInitialX: CGFloat = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if state == .tutorial {
            state = .play
            sceneDelegate?.didStartGame(self)
            return
        }
        
        guard let touch = touches.first else { return }
        
        shipInitialX = ship.position.x
        touchInitialX = touch.location(in: self).x
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let translation = touchInitialX - touch.location(in: self).x
        var x = shipInitialX - translation
        x = max(ship.size.width/2, x)
        x = min(frame.width - ship.size.width/2, x)
        
        ship.position.x = x
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        shipInitialX = 0
        touchInitialX = 0
    }
    
    // MARK: - States
    func stateChanged(to state: GameState) {
        switch state {
        case .tutorial:
            addTutorial()
        case .play:
            if Model.sharedInstance.sound {
                backgroundMusic.run(SKAction.play())
            }
            ship.ignite()
            removeTutorial()
        case .pause:
            backgroundMusic.run(SKAction.pause())
        case .end:
            shipFly()
            backgroundMusic.run(SKAction.stop())
            drinkMusic.run(SKAction.stop())
            break
        case .gameOver:
            scene?.isPaused = true
        }
    }
    
    //MARK: Score
    var score = 0 {
        didSet {
            sceneDelegate?.gameScene(self, scoreDidChange: score)
        }
    }
    
    func spawnBeer() {
        let beer = BeerNode.construct()
        let beerWidth = beer.size.width / 2
        beer.position = CGPoint(x: CGFloat.random(in: beerWidth ... frame.width - beerWidth), y: frame.height)
        addChild(beer)
        
        let actions: [SKAction] = [
            SKAction.moveTo(y: -beer.position.y, duration: beerSpeed),
            SKAction.removeFromParent()
        ]
        beer.run(SKAction.sequence(actions))
    }
    
    func shipFly() {
        let action = SKAction.moveTo(y: 900, duration: 15)
        ship.run(action)
        ship.fastFly()
    }
}
