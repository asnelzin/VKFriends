//
//  ViewController.swift
//  VKFriends
//
//  Created by Alexander Nelzin on 11/8/16.
//  Copyright © 2016 Alexander Nelzin. All rights reserved.
//

import UIKit


class ListTableViewController: UITableViewController {

    lazy var vkManager: VKAPIWorker = {
        let manager = VKAPIWorker.sharedInstance
        return manager
    }()

    @IBAction func refresh(_ sender: UIRefreshControl) {
        defer {
            sender.endRefreshing()
        }
        // vkManager.getFriendsList()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        NotificationCenter.default.addObserver(self, selector: #selector(self.didUpdateFriendsList(_:)), name: .friendsListUpdated, object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vkManager.friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let friend = vkManager.friends[indexPath.row]
        cell.textLabel?.text = friend.getName()
        return cell
    }
}


extension ListTableViewController {
    func didUpdateFriendsList(_ notification: Notification) {
        print(vkManager.friends)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
