//
//  ViewController.swift
//  Mapa
//
//  Created by Iuri Menin on 04/08/16.
//  Copyright © 2016 Iuri Menin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManag = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManag.delegate = self
        locationManag.desiredAccuracy = kCLLocationAccuracyBest
        locationManag.requestWhenInUseAuthorization()
        locationManag.startUpdatingLocation()
        
        let lat:CLLocationDegrees = -26.265453
        let lon:CLLocationDegrees = -52.784806
        
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = "Casa"
        annotation.subtitle = "Menin"
        
        map.addAnnotation(annotation)
        
        let pressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.action(_:)))
        
        pressedGesture.minimumPressDuration = 2
        
        map.addGestureRecognizer(pressedGesture)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        //posicao atual
        let userLocation:CLLocation = locations[0]
        
        let lat = userLocation.coordinate.latitude
        let lon = userLocation.coordinate.longitude
        
        let latDelta:CLLocationDegrees = 0.01
        let lonDelta:CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
    }
    
    func action(gesture: UIGestureRecognizer){
        
        let touchPoint = gesture.locationInView(self.map)
        
        let coordenate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = coordenate
        annotation.title = "Local"
        annotation.subtitle = "Selecionado pelo usuario"
        
        map.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

