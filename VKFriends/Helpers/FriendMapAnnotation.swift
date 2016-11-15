//
// Created by Alexander Nelzin on 15/11/16.
// Copyright (c) 2016 Alexander Nelzin. All rights reserved.
//

import Foundation
import MapKit


class FriendMapAnnotation: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  var title: String?
  var subtitle: String?

  init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String = "") {
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
  }
}
