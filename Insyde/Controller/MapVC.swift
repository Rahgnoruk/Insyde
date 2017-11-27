//
//  MapVC.swift
//  Insyde
//
//  Created by user132086 on 11/27/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var geoFire: GeoFire!
    var mapShouldCenter = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        geoFire = GeoFire(firebaseRef: DataService.ds.REF_SEMAFOROS)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            mapView.showsUserLocation = true
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            mapView.showsUserLocation = true
        }
    }
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        if let loc = userLocation.location{
            if mapShouldCenter{
                centerMapOnLocation(location: loc)
                mapShouldCenter = false
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        var annotationView: MKAnnotationView?
        let annotationIdentifier = "Semaforo"
        if annotation.isKind(of: MKUserLocation.self){
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier:"User")
            annotationView?.image = UIImage(named: "ash")
        }else if let dequeuedAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier){
            annotationView = dequeuedAnnotation
            annotationView?.annotation = annotation
        }else{
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        if let annotationView = annotationView, let securityAnnotation = annotation as? SecurityAnnotation{
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "\(securityAnnotation.promedio)")
            let btn = UIButton()
            btn.frame = CGRect(x:0, y:0, width: 30, height: 30)
            btn.setImage(UIImage(named:"map"), for: .normal)
            annotationView.rightCalloutAccessoryView = btn
        }
        
        return annotationView
    }
    
    func createSecurityAnnotation(forLocation location: CLLocation, inColonia colonia: Int){
        geoFire.setLocation(location, forKey: "\(colonia)")
    }
    
    func showCoordinatesOnMap(location: CLLocation){
        let circleQuery = geoFire!.query(at: location, withRadius: 2.5)
        
        _ = circleQuery?.observe(GFEventType.keyEntered, with: {(key, location) in
            if let key = key, let location = location {
                let annotation = SecurityAnnotation(coordinate: location.coordinate, colonia: key)
                self.mapView.addAnnotation(annotation)
            }
        })
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude,
                             longitude: mapView.centerCoordinate.longitude)
        showCoordinatesOnMap(location: loc)
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? SecurityAnnotation{
            let place = MKPlacemark(coordinate: annotation.coordinate)
            let destination = MKMapItem(placemark: place)
            destination.name = "Semaforo de Seguridad"
            let regionDistance: CLLocationDistance = 1000
            let regionSpan = MKCoordinateRegionMakeWithDistance(annotation.coordinate, regionDistance, regionDistance)
            
            let options = [MKLaunchOptionsMapCenterKey: NSValue (mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span),
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving] as [String : Any]
            
            MKMapItem.openMaps(with: [destination], launchOptions: options)
        }
    }
    func setAnnotation(){
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude,
                             longitude: mapView.centerCoordinate.longitude)
        let rand = arc4random_uniform(53)
        createSecurityAnnotation(forLocation: loc, inColonia: Int(rand))
    }
    @IBAction func ResetMapButton(_ sender: Any) {
        //centerMapOnLocation(location: mapView.userLocation.location!)
        setAnnotation()
    }
    
}
