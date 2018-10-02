//
//  ScoreViewController.swift
//  All Saints
//
//  Created by admin on 9/28/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ScoreViewController: UIViewController {
    var beersSpawned: Int = 1
    var score: Int = 0
    let ref = Database.database().reference()
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func didTapDoneButton(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "unwindToHomePage", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        scoreLabel.text = "\(Int(Double(score)/Double(beersSpawned)*100))%"
//        let userId = UUID().uuidString
//        let name = "ilyar"
//        ref.child("players").child(userId).setValue(["name": name,
//                                                     "score": score])
    }
}
