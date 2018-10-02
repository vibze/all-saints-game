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
//    let ref = Database.database().reference()
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        AppDelegate.shared.presentHomeViewController()
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let percent = Double(score)/Double(beersSpawned)*100
        scoreLabel.text = String(format: "%.2f", percent) + "%"
        let userId = UUID().uuidString
        let name = "viiiitya"
        FirebaseService.setNewScore(id: userId, name: name, score: percent)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 200
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += 200
        }
    }
}
