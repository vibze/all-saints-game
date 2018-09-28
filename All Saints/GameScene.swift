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
    
    let ship = Ship.construct(size: CGSize(width: 100, height: 140))
    
    var background: SKSpriteNode!
    var boomEmitter:SKEmitterNode!
    var pauseButton: SKSpriteNode!
    var swipeSprite: SKSpriteNode!
    var scoreLabel  = SKLabelNode()
//    var updateTime = TimeInterval()
//    var yieldTime  = TimeInterval()
    var counter = 60
    var counterTimer = Timer()
    // Touch handling
    var location = CGPoint.zero
    var entryX: CGFloat = 0
    var lock = false
    var playerEmitter = SKEmitterNode()
    var i: Float = 5
    var backgroundMusic = SKAudioNode()
    var crashMusic = SKAudioNode()
    
    let pauseView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
    
    private lazy var gameOverView: UIView = {
        let goview = UIView()
        goview.backgroundColor = UIColor(red: 69/255, green: 50/255, blue: 88/255, alpha: 100)
        goview.layer.borderWidth = 3
        goview.layer.borderColor = UIColor.white.cgColor
        return goview
    }()
    
    private lazy var gameOverLabel: UILabel = {
        let gameOver = UILabel()
        gameOver.text = "GAME OVER"
        gameOver.textColor = .white
//        gameOver.font = UIFont(name: "Ubuntu", size: screenWidth / 9.375 )
        return gameOver
    }()
    
    private lazy var finishScoreLabel: UILabel = {
        let finishScore = UILabel()
//        finishScore.font = UIFont(name: "Ubuntu", size: screenWidth / 12.5)
        finishScore.textColor = UIColor(red: 85/255, green: 190/255, blue: 240/255, alpha: 100)
        return finishScore
    }()
    
    private lazy var highScoreLabel: UILabel = {
        let highScore = UILabel()
//        highScore.font = UIFont(name: "Ubuntu", size: screenWidth / 12.5)
        highScore.textAlignment = .center
        highScore.textColor = UIColor(red: 85/255, green: 190/255, blue: 240/255, alpha: 100)
        return highScore
    }()
    
    private lazy var menuButton: UIButton = {
        let mButton = UIButton()
        mButton.setImage(#imageLiteral(resourceName: "earth"), for: .normal)
        mButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
        return mButton
    }()
    private lazy var restartButton: UIButton = {
        let gameRestart = UIButton()
        gameRestart.setImage(#imageLiteral(resourceName: "redo"), for: .normal)
        gameRestart.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        return gameRestart
    }()
    
    private lazy var restartLabel: UILabel = {
        let labelRestart = UILabel()
        labelRestart.text = "RESTART"
//        labelRestart.font = UIFont(name: "Ubuntu", size: screenWidth / 26.7 )
        labelRestart.textColor = .white
        return labelRestart
        
    }()
    private lazy var menuLabel: UILabel = {
        let labelMenu = UILabel()
        labelMenu.text = "MENU"
//        labelMenu.font = UIFont(name: "Ubuntu", size: screenWidth / 26.7 )
        labelMenu.textColor = .white
        return labelMenu
        
    }()
    
    // MARK: - Did move to skVIew
    override func didMove(to view: SKView) {
        ship.position = CGPoint(x: view.frame.width/2, y: view.frame.width - ship.size.height)
        addChild(ship)
        
        self.backgroundColor = UIColor(red: 53/255, green: 43/255, blue: 77/255, alpha: 100)
        setupWorldPhysics()
        moveBackground()
        createHUD()
        configurePauseView()
        
        crashMusic = SKAudioNode(fileNamed: "crash.mp3")
        crashMusic.run(SKAction.pause())
        addChild(crashMusic)
        
        if Model.sharedInstance.sound == true{
            backgroundMusic = SKAudioNode(fileNamed: "soundtrack.mp3")
            addChild(backgroundMusic)
        }
        state = .tutorial
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if state == .tutorial {
            state = .play
            return
        }
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        if node.name == "pauseButton" {
            state = .pause
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            location = touch.location(in: self)
            if !lock {
                entryX = location.x
                lock = true
            }
            let dX = abs(Int32(abs(Int32(location.x)) - abs(Int32(entryX))))
            if dX > 1 {
                ship.position.x = location.x
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lock = false
        entryX = 0.0
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
            removeTutorial()
            showHUD()
            playerEmitter.isHidden = false
        case .pause:
            pauseGame()
            backgroundMusic.run(SKAction.pause())
        case .end:
            stopGame()
        }
    }
    
    func configurePauseView() {
        pauseView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        let pauseLabel = UILabel(frame: CGRect(x: screenWidth / 3, y: screenHeight / 8, width: screenWidth / 1.87 , height: screenHeight / 3.32))
        pauseLabel.text = "PAUSE"
//        pauseLabel.font = UIFont(name: "Ubuntu", size: screenWidth / 9.375 )
        pauseLabel.textColor = .white
        
        let playButton = UIButton(frame: CGRect(x: screenWidth / 2.25, y: screenHeight / 2.5, width: screenHeight / 16, height: screenHeight / 16))
        playButton.setImage(#imageLiteral(resourceName: "music-player-play"), for: .normal)
        playButton.addTarget(self, action: #selector(backToGame), for: .touchUpInside)
        
        let restartButton = UIButton(frame: CGRect(x: screenWidth / 1.4 , y: screenHeight / 1.5, width: screenHeight / 18 , height: screenHeight / 18))
        restartButton.setImage(#imageLiteral(resourceName: "redo"), for: .normal)
        restartButton.addTarget(self, action: #selector(restartGame), for: .touchUpInside)
        let restartLabel = UILabel(frame: CGRect(x: screenWidth / 1.47, y: screenHeight / 1.38, width: screenHeight / 10, height: screenHeight / 10))
        restartLabel.text = "RESTART"
//        restartLabel.font = UIFont(name: "Ubuntu", size: screenWidth / 26.7 )
        restartLabel.textColor = .white
        
        let menuButton = UIButton(frame: CGRect(x: screenWidth / 4.4, y: screenHeight / 1.5, width: screenHeight / 16, height: screenHeight / 16))
        menuButton.setImage(#imageLiteral(resourceName: "earth"), for: .normal)
        menuButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)
        let menuLabel = UILabel(frame: CGRect(x: screenWidth / 4.45, y: screenHeight / 1.38, width: screenHeight / 10, height: screenHeight / 10))
        menuLabel.text = "MENU"
//        menuLabel.font = UIFont(name: "Ubuntu", size: screenWidth / 26.7 )
        menuLabel.textColor = .white
        
        pauseView.addSubview(restartButton)
        pauseView.addSubview(restartLabel)
        pauseView.addSubview(menuButton)
        pauseView.addSubview(menuLabel)
        pauseView.addSubview(playButton)
        pauseView.addSubview(pauseLabel)
    }
    
    func gameOverPresent(){
        view?.addSubview(self.gameOverView)
        scoreLabel.removeFromParent()
        
        finishScoreLabel.text = "SCORE: \(score)"
        
        let defaults = UserDefaults.standard
        if var scores = defaults.array(forKey: "scores") {
            scores.append(score)
            defaults.set(scores, forKey: "scores")
        } else {
            let scores = [score]
            defaults.set(scores, forKey: "scores")
        }
        
        var highScoreNumber = defaults.integer(forKey: "Saved")
        
        if score > highScoreNumber{
            highScoreNumber = score
            defaults.set(highScoreNumber, forKey: "Saved")
        }
        
        highScoreLabel.text = "BEST SCORE: \(highScoreNumber)"
        
        gameOverView.addSubview(gameOverLabel)
        gameOverView.addSubview(menuLabel)
        gameOverView.addSubview(restartLabel)
        gameOverView.addSubview(finishScoreLabel)
        gameOverView.addSubview(highScoreLabel)
        gameOverView.addSubview(restartButton)
        gameOverView.addSubview(menuButton)
    }
    
    // MARK: - Actions
    func addRandom(){
        let randomNumber = Int(arc4random_uniform(6))
//        addRow(type: RowType(rawValue: randomNumber)!)
        addBeers()
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
    
    func pauseGame(){
        hideHUD()
        view?.isPaused = true
        view?.addSubview(pauseView)
        
    }
    
    func stopGame(){
        self.view?.isPaused = true
        hideHUD()
        gameOverPresent()
    }
    
    @objc func backToGame() {
        state = .play
        pauseView.removeFromSuperview()
        self.view?.isPaused = false
        showHUD()
    }
    
    @objc func restartGame(){
        gameOverView.removeFromSuperview()
        pauseView.removeFromSuperview()
        let gameScene = GameScene(size: screenSize)
        self.view?.presentScene(gameScene)
    }
    
    @objc func backToMenu() {
        gameOverView.removeFromSuperview()
        pauseView.removeFromSuperview()
        //let gameScene = MenuScene(size: screenSize)
        //self.view?.presentScene(gameScene)
    }
}
