//
//  Post.swift
//  Insyde
//
//  Created by user132086 on 11/15/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import Foundation

class Post{
    private var _postId: String!
    private var _titulo: String!
    private var _descripcion: String!
    private var _imgURL: String!
    
    var postId: String{
        return _postId
    }
    var titulo: String{
        return _titulo
    }
    var descripcion: String{
        return _descripcion
    }
    var imgURL: String{
        return _imgURL
    }
    
    
    
    init(titulo: String, descripcion: String, imgURL: String){
        self._titulo = titulo
        self._descripcion = descripcion
        self._imgURL = imgURL
    }
    init(postId: String, postData: Dictionary<String, Any>){
        self._postId = postId
        if let titulo = postData["titulo"] as? String{
            self._titulo = titulo
        }
        if let descripcion = postData["descripcion"] as? String{
            self._descripcion = descripcion
        }
        if let imgURL = postData["imgURL"] as? String{
            self._imgURL = imgURL
        }
        
    }
}
