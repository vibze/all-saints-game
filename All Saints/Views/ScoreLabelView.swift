//
//  ScoreLabelView.swift
//  All Saints
//
//  Created by admin on 10/1/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit


@IBDesignable class ScoreLabelView: UIView {
    
    @IBInspectable var score: Int = 0 {
        didSet {
            pulse()
            label.text = score.description
        }
    }
    
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "beerImage"))
    private let label = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(imageView)
        addSubview(label)
        
        label.text = "0"
        label.font = UIFont(name: "American Typewriter", size: 22)
        label.textColor = .white
    }
    
    override func layoutSubviews() {
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        label.frame = CGRect(x: 30, y: 0, width: 50, height: 30)
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    private func pulse() {
        let anim = CABasicAnimation(keyPath: "transform.scale")
        anim.fromValue = 1
        anim.toValue = 1.4
        anim.repeatCount = 1
        anim.duration = 0.1
        anim.autoreverses = true
        layer.add(anim, forKey: "Pulse")
    }
}
