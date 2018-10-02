//
//  ScoreViewController.swift
//  All Saints
//
//  Created by admin on 9/28/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    var beersSpawned: Int = 1
    var score: Int = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        AppDelegate.shared.presentHomeViewController()
    }
    
    override func viewDidLoad() {
        scoreLabel.text = "\(Int(Double(score)/Double(beersSpawned)*100))%"
    }
}
