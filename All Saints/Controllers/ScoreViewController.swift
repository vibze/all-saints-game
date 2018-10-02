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
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        let percent = Double(score)/Double(beersSpawned)*100
        if let name = nameTextField.text,
            name != "" {
            let player = Player(id: UUID().uuidString, name: name, score: percent)
            FirebaseService.setNewScore(player: player)
        }
        AppDelegate.shared.presentHomeViewController()
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let percent = Double(score)/Double(beersSpawned)*100
        scoreLabel.text = String(format: "%.2f", percent) + "%"
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
