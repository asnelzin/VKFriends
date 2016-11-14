//
//  ViewController.swift
//  VKFriends
//
//  Created by Alexander Nelzin on 11/8/16.
//  Copyright © 2016 Alexander Nelzin. All rights reserved.
//

import UIKit


class ListTableViewController: UITableViewController {
    

    @IBAction func refresh(_ sender: UIRefreshControl) {
        defer {
            sender.endRefreshing()
        }

//        reloadTableView()
    }
    

    var friends = [VKFriend]()
    lazy var vkManager: VKAPIWorker = {
        let manager = VKAPIWorker.sharedInstance
        return manager
    }()
    
    override func loadView() {
        super.loadView()
        vkManager.friendsGet()
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        if vkManager.state == .authorized {
//            reloadTableView()
            print("YES!")
            print(vkManager.friends)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        reloadTableView()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.friends.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        /*if let cell = cell as? FriendTableViewCell{
            cell.configure(for: friends[row])
        }*/
        let friend = friends[row]
        let name = friend.getName()
        if friend.getCity() == "" {
            cell.textLabel?.text = name
        }
        else{
            cell.textLabel?.text = name + ": " + friend.getCity()
        }
        cell.imageView?.image = friend.profileImage.image

        return cell
    }
