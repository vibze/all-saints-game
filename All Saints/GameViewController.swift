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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gl = CAGradientLayer()
        gl.frame = view!.frame
        gl.colors = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor,#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).cgColor,#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor]
        gl.locations = [0, 1]
        view.layer.addSublayer(gl)
        
        let skView = SKView(frame: UIScreen.main.bounds)
        skView.ignoresSiblingOrder = true
        skView.showsPhysics = true //false
        skView.backgroundColor = .clear
        view.addSubview(skView)
        
        let scene = GameScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    
}
