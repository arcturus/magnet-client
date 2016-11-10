//
//  OneShotLocation.swift
//  Magnet
//
//  Created by Francisco Jordano on 09/11/2016.
//  Copyright © 2016 Mozilla. All rights reserved.
//

import Foundation
import CoreLocation

class OneShotLocation: NSObject, CLLocationManagerDelegate {
  let locationManager:CLLocationManager = CLLocationManager()
  var callback: ((CLLocation) -> Void)?
  var bestEffort: CLLocation?
  
  override init() {
    super.init()
  }
  
  func start(callback: (CLLocation) -> Void) {
    self.callback = callback
    self.bestEffort = nil
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    self.locationManager.distanceFilter = 5
    self.locationManager.headingFilter = 5
    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.startUpdatingLocation()
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard locations.count > 0 else {
      return
    }
    
    guard let location: CLLocation = locations.last else {
      return
    }
    
    guard location.horizontalAccuracy >= 0 else {
      return
    }
    
    guard bestEffort == nil || bestEffort!.horizontalAccuracy > location.horizontalAccuracy else {
      return
    }
    
    bestEffort = location
    
    guard location.horizontalAccuracy <= self.locationManager.desiredAccuracy else {
      Log.l("Discarding location \(location) because accuracy \(location.horizontalAccuracy) is \(self.locationManager.desiredAccuracy)")
      return;
    }
    
    self.locationManager.stopUpdatingLocation()
    NSObject.cancelPreviousPerformRequestsWithTarget(self)
    
    self.callback!(location)
    
  }
}
