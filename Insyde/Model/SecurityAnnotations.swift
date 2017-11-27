//
//  SecurityAnnotations.swift
//  Insyde
//
//  Created by user132086 on 11/27/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import Foundation

class SecurityAnnotation: NSObject, MKAnnotation{
    
    var coordinate : CLLocationCoordinate2D
    var _promedio : Int
    
    init(coordinate: CLLocationCoordinate2D, promedio: Int){
        self.coordinate = coordinate
        self._promedio = promedio
    }
    
}
