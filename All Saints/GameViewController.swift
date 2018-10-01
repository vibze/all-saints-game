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
    var totalScore = 0 {
        didSet {
            scoreLabel.score = totalScore
        }
    }

    let scene = GameScene(size: UIScreen.main.bounds.size)
    let pauseView = PauseView.fromXib
    
    //MARK: Counter
    var counter = 60 {
        didSet {
            guard counter >= 0 else {
                return
            }
            timerLabel.text = "\(counter)"
        }
    }
    var counterTimer = Timer()
    var didPause = false {
        didSet {
            startStopCounter()
        }
    }
    
    private func startStopCounter() {
        if !didPause {
            counterTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
            return
        }
        counterTimer.invalidate()
    }
    
    @objc private func decrementCounter() {
        counter -= 1
        scene.spawnBeer()
        scene.beerSpeed -= 0.05
        scene.shipSpeed -= 1
        
        guard counter == 0 else {
            return
        }
        scene.state = .end
        performSegue(withIdentifier: "showResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            let resultPage = segue.destination as! ScoreViewController
            resultPage.score = Double(totalScore)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skView.ignoresSiblingOrder = true
        skView.showsPhysics = true //false
        skView.backgroundColor = .clear
        
        scene.sceneDelegate = self
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    
    @IBAction func pauseTapped(_ sender: UIButton) {
        didPause = true
        pauseView.delegate = self
        scene.state = .pause
        scene.view?.isPaused = true
        view.addSubview(pauseView)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
}

extension GameViewController: PauseViewDelegate {
    func continueButtonPressed(_ pauseView: PauseView) {
        didPause = false
        scene.state = .play
        scene.view?.isPaused = false
        pauseView.removeFromSuperview()
    }
}

extension GameViewController: GameSceneDelegate {
    func didStartGame(_ gameScene: GameScene) {
        startStopCounter()
    }
    
    func gameScene(_ gameScene: GameScene, scoreDidChange score: Int) {
        totalScore = score
    }
}
