//
//  ActionButton.swift
//  All Saints
//
//  Created by admin on 9/28/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

@IBDesignable class ActionButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let backgroundLayer = CALayer()
    let etchLayer = CALayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.addSublayer(etchLayer)
        layer.addSublayer(backgroundLayer)
        
        backgroundLayer.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.47, alpha: 1).cgColor
        backgroundLayer.cornerRadius = 6
        etchLayer.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0.26, alpha: 1).cgColor
        etchLayer.cornerRadius = 6
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundLayer.frame = bounds
        etchLayer.frame = bounds
        etchLayer.frame.origin.y = 6
    }
}
