//
//  GameScene.swift
//  space
//
//  Created by Kamila Kusainova on 26.06.17.
//  Copyright © 2017 sdu. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var state = GameState.tutorial {
        didSet {
            stateChanged(to: state)
        }
    }
    
    var score = 0
    
    let ship = Ship.construct()
    
    var background: SKSpriteNode!
    var boomEmitter:SKEmitterNode!
    var swipeSprite: SKSpriteNode!
//    var scoreLabel = SKLabelNode()
//    var timerLabel = SKLabelNode()
//    var updateTime = TimeInterval()
//    var yieldTime  = TimeInterval()
    //MARK: Counter
    var counter = 0
    var counterTimer = Timer()
    var counterStartValue = 60
    
    // Touch handling
    var i: Float = 5
    var backgroundMusic = SKAudioNode()
    var crashMusic = SKAudioNode()
    
//    let pauseView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
    
//    private lazy var menuButton: UIButton = {
//        let mButton = UIButton()
//        mButton.setImage(#imageLiteral(resourceName: "earth"), for: .normal)
//        mButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
//        return mButton
//    }()
//    private lazy var restartButton: UIButton = {
//        let gameRestart = UIButton()
//        gameRestart.setImage(#imageLiteral(resourceName: "redo"), for: .normal)
//        gameRestart.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
//        return gameRestart
//    }()
//
//    private lazy var restartLabel: UILabel = {
//        let labelRestart = UILabel()
//        labelRestart.text = "RESTART"
////        labelRestart.font = UIFont(name: "Ubuntu", size: screenWidth / 26.7 )
//        labelRestart.textColor = .white
//        return labelRestart
//    }()
//
//    private lazy var menuLabel: UILabel = {
//        let labelMenu = UILabel()
//        labelMenu.text = "MENU"
////        labelMenu.font = UIFont(name: "Ubuntu", size: screenWidth / 26.7 )
//        labelMenu.textColor = .white
//        return labelMenu
//
//    }()
    
    // MARK: - Did move to skVIew
    override func didMove(to view: SKView) {
        ship.position = CGPoint(x: view.frame.width/2, y: view.frame.width - ship.size.height - 40)
        addChild(ship)
        
        backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1607843137, blue: 0.06274509804, alpha: 1)
        setupWorldPhysics()
        moveBackground()
        
        if let url = Bundle.main.url(forResource: "gulp-1.mp3", withExtension: "mp3") {
            crashMusic = SKAudioNode(url: url)
            addChild(crashMusic)
        }
        
        if let url = Bundle.main.url(forResource: "soundtrack.mp3", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: url)
            addChild(backgroundMusic)
        }
        state = .tutorial
        
        counter = counterStartValue
        startCounter()
    }
    
    private func startCounter() {
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    
    @objc private func decrementCounter(value: Int = 1) {
        counter -= value
    }
    
    // MARK: - Scene ovrrided methods
    override func update(_ currentTime: TimeInterval) {
//        var timeSinceLastUpdate = currentTime - updateTime
//        updateTime = currentTime
//        if state == .play{
//            i -= 0.003
//        }
//        if timeSinceLastUpdate > 2.0{
//            timeSinceLastUpdate = 1/60
//            updateTime = currentTime
//        }
//        guard state == .play else { return }
//        updateTimerInterval(timeSinceLastUpdate: timeSinceLastUpdate)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        ship.ignite()
        if contact.bodyA.node?.name == "player" { state = .end }
    }
    
    
    var shipInitialX: CGFloat = 0
    var touchInitialX: CGFloat = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if state == .tutorial {
            state = .play
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
            if Model.sharedInstance.sound == true {
                backgroundMusic.run(SKAction.play())
            }
            ship.ignite()
            removeTutorial()
        case .pause:
//            pauseGame()
            backgroundMusic.run(SKAction.pause())
        case .end:
            break
//            stopGame()
        }
    }
    
    func updateTimerInterval(timeSinceLastUpdate: TimeInterval){
//        yieldTime += timeSinceLastUpdate
//        if yieldTime > 1.5{
//            yieldTime = 0
//            score+=1
//            scoreLabel.text = "\(score)"
//            addRandom()
//        }
    }
    
    func spawnBeer() {
        let beer = BeerNode.construct()
        beer.position = CGPoint(x: CGFloat.random(in: 0 ... frame.width), y: -100)
        addChild(beer)
        
        let actions: [SKAction] = [
            SKAction.moveBy(x: 0, y: frame.height + 200, duration: 1),
            SKAction.removeFromParent()
        ]
        beer.run(SKAction.sequence(actions))
    }
}
