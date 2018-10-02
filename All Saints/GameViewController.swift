//
//  GameViewController.swift
//  space
//
//  Created by Kamila Kusainova on 26.06.17.
//  Copyright © 2017 sdu. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var skView: SKView!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: ScoreLabelView!
    
    var isPaused = false
    var beersSpawned: Int = 0
    var totalScore = 0 {
        didSet {
            scoreLabel.score = totalScore
        }
    }

    let scene = GameScene(size: UIScreen.main.bounds.size)
    let pauseView = PauseView.fromXib
    
    //MARK: Counter
    var counter = 30 {
        didSet {
            guard counter >= 0 else {
                return
            }
            timerLabel.text = "\(counter)"
        }
    }
    
    var roundTimer: Timer?
    var beerTimer: Timer?
    var difficultyLevel: Int = 0 {
        didSet {
            beerTimer?.invalidate()
            switch difficultyLevel {
            case 0:
                scene.beerSpeed = 3
                beerTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(spawnBeer), userInfo: nil, repeats: true)
            case 1:
                scene.beerSpeed = 2.5
                beerTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(spawnBeer), userInfo: nil, repeats: true)
            case 2:
                scene.beerSpeed = 2.5
                beerTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(spawnBeer), userInfo: nil, repeats: true)
            case 3:
                scene.beerSpeed = 2
                beerTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(spawnBeer), userInfo: nil, repeats: true)
            case 4:
                scene.beerSpeed = 2
                beerTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(spawnBeer), userInfo: nil, repeats: true)
            case 5:
                scene.beerSpeed = 1.5
                beerTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(spawnBeer), userInfo: nil, repeats: true)
            case 6:
                scene.beerSpeed = 1.5
                beerTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(spawnBeer), userInfo: nil, repeats: true)
            case 7:
                scene.beerSpeed = 1
                beerTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(spawnBeer), userInfo: nil, repeats: true)
            case 8:
                scene.beerSpeed = 1
                beerTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(spawnBeer), userInfo: nil, repeats: true)
            case 9:
                scene.beerSpeed = 0.7
                beerTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(spawnBeer), userInfo: nil, repeats: true)
            default:
                scene.beerSpeed = 0.4
                beerTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(spawnBeer), userInfo: nil, repeats: true)
            }
        }
    }
    
    private func startStopCounter() {
        roundTimer?.invalidate()
        roundTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    
    @objc private func decrementCounter() {
        guard !isPaused else { return }
        
        if counter >= 1 {
            counter -= 1
        } else {
            roundTimer?.invalidate()
            scene.state = .end
            performSegue(withIdentifier: "showResult", sender: self)
        }
    }
    
    @objc private func spawnBeer() {
        guard !isPaused else { return }
        
        beersSpawned += 1
        scene.spawnBeer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            let resultPage = segue.destination as! ScoreViewController
            resultPage.beersSpawned = beersSpawned
            resultPage.score = totalScore
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skView.ignoresSiblingOrder = true
        skView.showsPhysics = false
        skView.backgroundColor = .clear
        
        scene.sceneDelegate = self
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    
    @IBAction func pauseTapped(_ sender: UIButton) {
        pause()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    fileprivate func pause() {
        isPaused = true
        pauseView.delegate = self
        scene.state = .pause
        scene.view?.isPaused = true
        view.addSubview(pauseView)
        pauseView.frame = view.bounds
        pauseView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.pauseView.alpha = 1
        }
    }
    
    fileprivate func resume() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pauseView.alpha = 0
        }) { result in
            self.pauseView.removeFromSuperview()
            self.isPaused = false
            self.scene.state = .play
            self.scene.view?.isPaused = false
        }
    }
}

extension GameViewController: PauseViewDelegate {
    func continueButtonPressed(_ pauseView: PauseView) {
        resume()
    }
}

extension GameViewController: GameSceneDelegate {
    func didStartGame(_ gameScene: GameScene) {
        startStopCounter()
        difficultyLevel = 0
    }
    
    func gameScene(_ gameScene: GameScene, scoreDidChange score: Int) {
        totalScore = score
        if score % 7 == 0 {
            difficultyLevel += 1
        }
        gameScene.ship.setRandomPhoto()
    }
}
