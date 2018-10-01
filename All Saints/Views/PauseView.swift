//
//  PauseView.swift
//  All Saints
//
//  Created by ilyar on 10/1/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

protocol PauseViewDelegate: class {
    func continueButtonPressed(_ pauseView: PauseView)
}

class PauseView: UIView {
    @IBOutlet weak var continueButton: UIButton!
    weak var delegate: PauseViewDelegate?
    
    @IBAction func continueTapped(_ sender: UIButton) {
        delegate?.continueButtonPressed(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
