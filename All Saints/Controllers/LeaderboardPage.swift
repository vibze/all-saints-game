//
//  LeaderboardPage.swift
//  All Saints
//
//  Created by ilyar on 10/2/18.
//  Copyright © 2018 DAR. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LeaderboardPage: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var topPlayers = [Player]()
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        FirebaseService.getAllPlayers { players in
            self.topPlayers = players
            self.indicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlayerCell.nib, forCellReuseIdentifier: PlayerCell.name)
    }
    
    @IBAction func tryButtonTapped(_ sender: ActionButton) {
        AppDelegate.shared.presentHomeViewController()
    }
}

extension LeaderboardPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlayerCell.name, for: indexPath) as! PlayerCell
        cell.setupCell(player: topPlayers[indexPath.row])
        return cell
    }
}
