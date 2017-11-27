//
//  SecurityAnnotations.swift
//  Insyde
//
//  Created by user132086 on 11/27/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import Foundation
import MapKit
let semaforos = ["1", "2", "3"]
class SecurityAnnotation: NSObject, MKAnnotation{
    
    var coordinate : CLLocationCoordinate2D
    var promedio : Int
    var semaforo: String
    var colonia: String
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, colonia: String){
        self.coordinate = coordinate
        self.promedio = 2
        self.semaforo = semaforos[promedio]
        self.colonia = colonia
        self.title = self.colonia;
    }
    
}
