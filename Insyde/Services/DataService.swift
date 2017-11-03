//
//  DataService.swift
//  Insyde
//
//  Created by user132086 on 11/2/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()


class DataService{
    static let ds = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    var REF_BASE: DatabaseReference{
        return _REF_BASE
    }
    var REF_POSTS: DatabaseReference{
        return _REF_POSTS
    }
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    
    func createFirebaseUser(uid: String, userData: Dictionary<String, String>){
        _REF_USERS.child(uid).updateChildValues(userData)
        
    }
}
