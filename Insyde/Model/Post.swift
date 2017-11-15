//
//  Post.swift
//  Insyde
//
//  Created by user132086 on 11/15/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import Foundation

class Post{
    private var _autores: String!
    private var _pdfURL: String!
    private var _titulo: String!
    private var _postId: String!
    
    var autores: String{
        return _autores
    }
    var pdfURL: String{
        return _pdfURL
    }
    var titulo: String{
        return _titulo
    }
    var postId: String{
        return _postId
    }
    
    init(autores: String, pdfURL: String, titulo: String){
        self._autores = autores
        self._pdfURL = pdfURL
        self._titulo = titulo
    }
    init(postId: String, postData: Dictionary<String, Any>){
        self._postId = postId
        if let autores = postData["autores"] as? String{
            self._autores = autores
        }
        if let pdfURL = postData["pdfURL"] as? String{
            self._pdfURL = pdfURL
        }
        if let titulo = postData["titulo"] as? String{
            self._titulo = titulo
        }
        
    }
}
