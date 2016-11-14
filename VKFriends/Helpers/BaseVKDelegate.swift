//
//  BaseVKDelegate.swift
//  VKFriends
//
//  Created by Alexander Nelzin on 11/14/16.
//  Copyright © 2016 Alexander Nelzin. All rights reserved.
//

import Foundation
import SwiftyVK


class BaseVKDelegate: VKDelegate {
    init() {
        VK.configure(appID: Constants.appID, delegate: self)
    }
    
    func vkWillAuthorize() -> [VK.Scope] {
        return [.offline, .friends]
    }
    
    func vkDidUnauthorize() {
        // Called when user is log out.
    }
    
    func vkAutorizationFailedWith(error: VK.Error) {
        // Called when SwiftyVK could not authorize. To let the application know that something went wrong.
        print(error)
        abort()
    }
    
    func vkShouldUseTokenPath() -> String? {
        // Called when SwiftyVK need know where a token is located.
        return nil // Path to save/read token or nil if should save token to UserDefaults
    }
    
    func vkWillPresentView() -> UIViewController {
        // Called when need to display a view from SwiftyVK.
        return UIApplication.shared.delegate!.window!!.rootViewController!
    }
    
    
    func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
        // Called when the user is log in.
        // Here you can start to send requests to the API.
        VKAPIWorker.sharedInstance.getFriendsList()
    }
}
