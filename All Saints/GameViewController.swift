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
    @IBOutlet weak var scoreLabel: UILabel!
    let scene = GameScene(size: UIScreen.main.bounds.size)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skView.ignoresSiblingOrder = true
        skView.showsPhysics = true //false
        skView.backgroundColor = .clear
        
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    
    
    @IBAction func pauseTapped(_ sender: UIButton) {
        scene.state = .pause
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    
}
