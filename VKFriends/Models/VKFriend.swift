//
// Created by Alexander Nelzin on 14/11/16.
// Copyright (c) 2016 Alexander Nelzin. All rights reserved.
//

import Foundation
import MapKit
import UIKit


class VKFriend {
  private(set) var id: String
  private(set) var name: String

  private(set) var image: UIImageView?
  private(set) var coordinates: CLLocationCoordinate2D?

  init(id: String, name: String, city: String) {
    self.id = id
    self.name = name
    
    if !city.isEmpty {
      CLGeocoder().geocodeAddressString(city, completionHandler: { (placemarks, error) in
        guard error == nil else {
          return
        }
        if let placemark = placemarks?[0], let location = placemark.location {
          self.coordinates = location.coordinate
        }
      })
    }
  }
}
