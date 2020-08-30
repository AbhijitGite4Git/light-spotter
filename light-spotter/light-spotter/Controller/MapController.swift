//
//  ViewController.swift
//  light-spotter
//
//  Created by Abhijit Gite on 28/8/20.
//  Copyright © 2020 Abhijit Gite. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Reachability

/*
 Initial View Controller with maps
 */
class MapController: UIViewController {
    
    let locationManager = CLLocationManager()
    let viewModelLights = LightsViewModel()
    let reachability = try! Reachability()
    var selectedCamera = Cameras()
    
    @IBOutlet weak var gMapView: GMSMapView!
    
    //View Contoller Delegate Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelLights.vc = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if reachability.connection != .unavailable {
            self.viewModelLights.getAllCameras()
        }else{
            showNetWorkAlert()
        }
    }

    //Load Default Map settings
    func loadDefaultMapSettings(){
        
       gMapView.delegate = self
       gMapView.settings.compassButton = true
       gMapView.isMyLocationEnabled = true
       gMapView.settings.myLocationButton = true
       getCurrentLocation()
    }
    
    //Request and get cuurent locaiton
    func getCurrentLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    //Load custom markers
    func loadMarkers(){
        
        self.gMapView.clear()
        
        //Center to detfault Singapore Location
        
        let cord2D = CLLocationCoordinate2D(latitude: selectedCamera.location.latitude, longitude: selectedCamera.location.longitude)
        
        if self.viewModelLights.resultCameras.count > 0 {
            for markers in self.viewModelLights.resultCameras{
                let location = CLLocationCoordinate2D(latitude: (markers.location.latitude), longitude: (markers.location.longitude))
                     let marker = GMSMarker()
                     marker.position = location
                     marker.snippet = markers.camera_id
                     marker.map = self.gMapView
                   }
        }
       
        self.gMapView.camera = GMSCameraPosition.camera(withTarget: cord2D, zoom: 12)
    }
    
    //Update Destination view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ListDetailVC {
            destination.camera = self.selectedCamera
        }
    }
    
    //Show network alert if not available
    func showNetWorkAlert(){
        let alert = UIAlertController(
               title: noNetworkConnected,
               message: tryAgain,
               preferredStyle: .alert
             )
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
               alert.dismiss(animated: true, completion: nil)
             }))
             self.present(alert, animated: true, completion: nil)
    }
    
    //Refresh map manually 
    @IBAction func refreshData(_ sender: Any) {
        if reachability.connection != .unavailable {
            self.viewModelLights.getAllCameras()
        }
        else{
            showNetWorkAlert()
        }
    }
}

extension MapController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        print("Locations = \(locValue.latitude) : \(locValue.longitude)")
        
    }
}

extension MapController : GMSMapViewDelegate {
    
    //GMS delegate
      func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
          print("Map finished loading")
      }
      
      func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
             if marker.snippet != nil {
                 print("didTap marker \(String(describing: marker.snippet))")
                 self.selectedCamera =  find(value: marker.snippet ?? "NA", in: self.viewModelLights.resultCameras)
                 performSegue(withIdentifier: "showImage", sender: self)
             }
             return true
      }
}


