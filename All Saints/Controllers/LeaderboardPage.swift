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
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    private func setupTable() {
        tableView.register(PlayerCell.self, forCellReuseIdentifier: "playerCell")
    }
    
    @IBAction func tryButtonTapped(_ sender: ActionButton) {
        debugPrint("try button tapped")
    }
}

extension LeaderboardPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
        return cell
    }
    
}
