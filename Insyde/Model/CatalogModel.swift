//
//  CatalogCell.swift
//  Insyde
//
//  Created by user132086 on 11/25/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import Foundation

class CatalogModel{
    private var _nombre: String!

    var nombre: String{
        return _nombre
    }
    
    init(nombre: String){
        self._nombre = nombre
    }
}

