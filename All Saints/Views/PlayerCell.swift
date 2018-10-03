//
//  PlayerCell.swift
//  All Saints
//
//  Created by ilyar on 10/2/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell, NibGettable {
    typealias View = PlayerCell
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.backgroundColor = .clear
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
    }
    
    func setupCell(player: Player) {
        nameLabel.text = player.name
        scoreLabel.text = String(format: "%.2f", player.score) + "%"
    }
}
