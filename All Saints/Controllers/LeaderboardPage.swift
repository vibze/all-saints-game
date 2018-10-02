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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        
        ref.observe(.value) { (snapshot) in
            var players = [Player]()
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let player = Player(snapshot: snapshot) {
                    players.append(player)
                }
            }
            self.topPlayers = players
            self.topPlayers.sort(by: { (lPlayer, rPlayer) -> Bool in
                lPlayer.score > rPlayer.score
            })
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
