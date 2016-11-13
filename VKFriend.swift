//
// Created by Alexander Nelzin on 14/11/16.
// Copyright (c) 2016 Alexander Nelzin. All rights reserved.
//

import Foundation
import UIKit
//import SDWebImage
import MapKit


class VKFriend {
    private var name: String = ""
    private var city: String = ""
    private var id: String = ""

    var profileImage: UIImageView = UIImageView()

    var linkProfileImage: String = "" {
        didSet {
            reloadProfileImage()
        }
    }

    var coordinates: CLLocationCoordinate2D


    init(name: String, city: String?, id: String, linkProfileImage: String) {
        self.name = name
        if let cityName = city {
            self.city = cityName
        }
        self.id = id
        self.linkProfileImage = linkProfileImage
        self.coordinates = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        getCoordinates()
    }

    func reloadProfileImage() {
        if linkProfileImage == "" {
            profileImage.image = #imageLiteral(resourceName: "camera")
        } else {
            //profileImage.image = UIImage(named: "reloadControlGif")
//            profileImage.sd_setImage(with: URL(string: linkProfileImage))
        }
    }

    // TODO: Refactor to in-property getters

    func getName() -> String {
        return name
    }

    func getCity() -> String {
        return city
    }

    func getId() -> String {
        return id
    }

    func getLinkPhoto() -> String {
        return linkProfileImage
    }

    func getCoordinates() {
        let geocoder = CLGeocoder()

        if city == "" {
            return
        }

        geocoder.geocodeAddressString(city, completionHandler: {
            (placemark, error) in
            if error != nil {
                return
            }
            if let location = placemark?[0].location?.coordinate {
                self.coordinates = location
            }
        })
    }
}
