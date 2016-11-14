//
// Created by Alexander Nelzin on 14/11/16.
// Copyright (c) 2016 Alexander Nelzin. All rights reserved.
//

import Foundation
import SwiftyVK
import Alamofire


class VKAPIWorker {

    var friends = [VKFriend]()

    
    // MARK: - Shared instance

    static let sharedInstance: VKAPIWorker = {
        let instance = VKAPIWorker()
        return instance
    }()


    // MARK: - Methods
    
    func getFriendsList() {
        let req = VK.API.Friends.get([
                .count: "0",
                .fields: "city,domain"
        ])

        req.successBlock = {
            response in
            self.friends.removeAll()

            for friend in response["items"].arrayValue {
                self.friends.append(VKFriend(
                        name: "\(friend["last_name"].stringValue) \(friend["first_name"].stringValue)",
                        city: friend["city", "title"].string ?? "",
                        id: friend["id"].stringValue,
                        linkProfileImage: ""
                    )
                )
            }
            NotificationCenter.default.post(name: .friendsListUpdated, object: nil)
        }

        req.errorBlock = {
            error in
            print("Couldn't get a friends list.")
            abort()
        }

        req.send()
    }
}
