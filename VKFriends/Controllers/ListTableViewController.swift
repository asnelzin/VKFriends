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
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.didUpdateFriendsList(_:)), name: .friendsListUpdated, object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vkManager.friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        /*if let cell = cell as? FriendTableViewCell{
            cell.configure(for: friends[row])
        }*/
        let friend = vkManager.friends[row]
        let name = friend.getName()
        if friend.getCity() == "" {
            cell.textLabel?.text = name
        } else {
            cell.textLabel?.text = name + ": " + friend.getCity()
        }
        cell.imageView?.image = friend.profileImage.image

        return cell
    }
}


extension ListTableViewController {
    func didUpdateFriendsList(_ notification: Notification) {
        print(vkManager.friends)
    }
}
