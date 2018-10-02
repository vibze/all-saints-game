//
//  HomeViewController.swift
//  All Saints
//
//  Created by admin on 9/28/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
    @IBOutlet weak var soundToggle: UISwitch!
    @IBAction func didChangeSoundToggle(_ sender: UISwitch) {
        Model.sharedInstance.sound = sender.isOn
    }
    
    
    @IBAction func didTapStartButton(_ sender: Any) {
        AppDelegate.shared.presentGameViewController()
    }
    
    @IBAction func didTapLeadersButton(_ sender: Any) {
        AppDelegate.shared.presentLeaderBoardViewControler()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soundToggle.isOn = Model.sharedInstance.sound
    }
}
