//
//  PublicacionModel.swift
//  Insyde
//
//  Created by user132086 on 11/25/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import Foundation

class PublicacionModel{
    private var _publicacionId: String!
    private var _titulo: String!
    private var _imgURL: String!
    private var _pdfURL: String!
    private var _descripcion: String!
    
    var publicacionId: String{
        return _publicacionId
    }
    var titulo: String{
        return _titulo
    }
    var imgURL: String{
        return _imgURL
    }
    var pdfURL: String{
        return _pdfURL
    }
    var descripcion: String{
        return _descripcion
    }
    
    init(titulo: String, imgURL: String, pdfURL: String, descripcion: String){
        self._titulo = titulo
        self._imgURL = imgURL
        self._pdfURL = pdfURL
        self._descripcion = descripcion
    }
    
    init(publicacionId: String, postData: Dictionary<String, Any>){
        self._publicacionId = publicacionId
        if let titulo = postData["titulo"] as? String{
            self._titulo = titulo
        }
        if let imgURL = postData["imgURL"] as? String{
            self._imgURL = imgURL
        }
        if let pdfURL = postData["pdfURL"] as? String{
            self._pdfURL = pdfURL
        }
        if let descripcion = postData["descripcion"] as? String{
            self._descripcion = descripcion
        }
    }
}
