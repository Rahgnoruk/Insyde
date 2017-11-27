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
let STORAGE_BASE = Storage.storage().reference()

class DataService{
    static let ds = DataService()
    //DB References
    private var _REF_BASE = DB_BASE
    private var _REF_TOPS = DB_BASE.child("Tops")
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_DENUNCIAS = DB_BASE.child("denuncias")
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_CATALOGOS = DB_BASE.child("Catalogos")
    
    private var _REF_ACERVOVIRTUAL = DB_BASE.child("Acervo Virtual")
    private var _REF_COMUNICADOSDEPRENSA = DB_BASE.child("Comunicados de Prensa")
    private var _REF_CUADERNOSDETRABAJO = DB_BASE.child("Cuadernos de Trabajo")
    private var _REF_DOCUMENTOSACADEMICOS = DB_BASE.child("Documentos Academicos")
    private var _REF_LIBROS = DB_BASE.child("Libros")
    private var _REF_NOTICIAS = DB_BASE.child("Noticias")
    //Storage References, se usan para hacer upload
    private var _REF_POST_IMAGES = STORAGE_BASE.child("pdfArticulos")
    
    var REFS: Dictionary<String, DatabaseReference>{
        return ["Acervo Virtual": _REF_ACERVOVIRTUAL,
                "Comunicados de Prensa": _REF_COMUNICADOSDEPRENSA,
                "Cuadernos de Trabajo": _REF_CUADERNOSDETRABAJO,
                "Documentos Academicos": _REF_DOCUMENTOSACADEMICOS,
                "Libros": _REF_LIBROS,
                "Noticias":_REF_NOTICIAS]
    }
    
    var REF_BASE: DatabaseReference{
        return _REF_BASE
    }
    var REF_POSTS: DatabaseReference{
        return _REF_POSTS
    }
    var REF_DENUNCIAS: DatabaseReference{
        return _REF_DENUNCIAS
    }
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    var REF_CATALOGOS: DatabaseReference{
        return _REF_CATALOGOS
    }
    var REF_ACERVOVIRTUAL: DatabaseReference{
        return _REF_ACERVOVIRTUAL
    }
    var REF_COMUNICADOSDEPRENSA: DatabaseReference{
        return _REF_COMUNICADOSDEPRENSA
    }
    var REF_CUADERNOSDETRABAJO: DatabaseReference{
        return _REF_CUADERNOSDETRABAJO
    }
    var REF_DOCUMENTOSACADEMICOS: DatabaseReference{
        return _REF_DOCUMENTOSACADEMICOS
    }
    var REF_LIBROS: DatabaseReference{
        return _REF_LIBROS
    }
    var REF_NOTICIAS: DatabaseReference{
        return _REF_NOTICIAS
    }
    
    var REF_POST_IMAGES: StorageReference{
        return _REF_POST_IMAGES
    }
    
    func createFirebaseUser(uid: String, userData: Dictionary<String, String>){
        _REF_USERS.child(uid).updateChildValues(userData)
        
    }
}
