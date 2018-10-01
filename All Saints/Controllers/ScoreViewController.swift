//
//  ScoreViewController.swift
//  All Saints
//
//  Created by admin on 9/28/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    var score: Double = 0 {
        didSet {
            score = score/60
        }
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "unwindToHomePage", sender: self)
    }
    
    override func viewDidLoad() {
        scoreLabel.text = "\(Int(score*100))%"
    }
}
