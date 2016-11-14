//
// Created by Alexander Nelzin on 14/11/16.
// Copyright (c) 2016 Alexander Nelzin. All rights reserved.
//

import Foundation
import SwiftyVK
import Alamofire


protocol VKAPIWorkerDeligate {
    func didUpdateFriendsList()
}

class VKAPIWorker {
    
    var deligate: VKAPIWorkerDeligate?
    
    var friends = [VKFriend]()

    var state: VK.States {
        get {
            return VK.state
        }
    }

    // MARK: - Shared instance
    
    static let sharedInstance: VKAPIWorker = {
        let instance = VKAPIWorker()
        return instance
    }()


//    func getFriendPhotoLink(friend: VKFriend) {
//        _ = VK.API.Photos.get([
//                .ownerId: "\(friend.getId())",
//                .albumId: "profile"]).send(
//                onSuccess: {
//                    response in
//                    friend.linkProfileImage = response["items", response["count"].intValue - 1, "photo_130"].stringValue
//                },
//                onError: {
//                    error in print("SwiftyVK: photosGet fail \n \(error)")
//                    friend.linkProfileImage = ""
//                })
//    }
//
    func getFriendsList() {
        let req = VK.API.Friends.get([
                .count: "0",
                .fields: "city,domain"
        ])
        req.successBlock = {
            response in
            //cleaning array
            self.friends.removeAll()
            //getting Friends names, their cities and profile photos
            for friend in response["items"].arrayValue {
                var cityFriend = ""
                if let cityName = friend["city", "title"].string {
                    cityFriend = cityName
                }
                let newFriend =
                VKFriend(name: "\(friend["last_name"].stringValue) \(friend["first_name"].stringValue)",
                        city: cityFriend,
                        id: friend["id"].stringValue,
                        linkProfileImage: "")
                self.friends.append(newFriend)
//                self.getFriendPhotoLink(friend: newFriend)
            }
            NotificationCenter.default.post(name: .friendsListUpdated, object: nil)
        }
        req.errorBlock = {
            error in print("error")
        }
        req.send()
    }
}
