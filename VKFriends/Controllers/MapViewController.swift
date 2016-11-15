//
// Created by Alexander Nelzin on 14/11/16.
// Copyright (c) 2016 Alexander Nelzin. All rights reserved.
//

import CoreLocation
import Foundation
import MapKit
import UIKit


class MapViewController: UIViewController {

  @IBOutlet weak var map: MKMapView!

  lazy var vkManager: VKAPIWorker = {
    let manager = VKAPIWorker.sharedInstance
    return manager
  }()

  lazy var locationManager: CLLocationManager = {
    let locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    return locationManager
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    NotificationCenter.default.addObserver(self, selector: #selector(self.didUpdateFriendsList(_:)),
        name: .friendsListUpdated, object: nil)

    locationManager.startUpdatingLocation()

    reloadAnnotations()
  }
}


// MARK: - Update map
extension MapViewController {
  func reloadAnnotations() {
    for friend in vkManager.friends {
      if let coordinates = friend.coordinates {
        map.addAnnotation(FriendMapAnnotation(coordinate: coordinates, title: friend.name))
      }
    }
  }
}


// MARK: - Notifications handlers
extension MapViewController {
  func didUpdateFriendsList(_ notification: Notification) {
    reloadAnnotations()
  }
}


// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("didFailWithError %@", error)
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      let span = MKCoordinateSpanMake(20, 20)
      let region = MKCoordinateRegion(center: location.coordinate, span: span)
      map.setRegion(region, animated: true)
    }
    locationManager.stopUpdatingLocation()
  }
}


// MARK: - MapView
extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is MKUserLocation {
      return nil
    }

    let identifier = "Pin"

    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

    if annotationView == nil {
      annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      annotationView?.canShowCallout = false
    } else {
      annotationView?.annotation = annotation
    }
    return annotationView
  }
}
