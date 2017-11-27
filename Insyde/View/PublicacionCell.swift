//
//  PublicacionCell.swift
//  Insyde
//
//  Created by user132086 on 11/25/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import UIKit
import Firebase

class PublicacionCell: UITableViewCell {

    @IBOutlet weak var titulo: UITextView!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var descripcion: UITextView!
    
    var publicacionModel: PublicacionModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(publicacionModel: PublicacionModel, img: UIImage? = nil){
        self.publicacionModel = publicacionModel
        self.titulo.text = publicacionModel.titulo
        self.descripcion.text = publicacionModel.descripcion
        
        if img != nil{
            self.imagen.image = img
        }else{
            let ref = Storage.storage().reference(forURL: publicacionModel.imgURL)
            ref.getData(maxSize: 2*1024*1024, completion: {(data, error) in
                if error != nil{
                    print("TONY: Unable to download image from storage")
                }else{
                    if let imgData = data{
                        if let img = UIImage(data: imgData){
                            self.imagen.image = img
                            DesplegarCatalogoVC.imageCache.setObject(img, forKey: publicacionModel.pdfURL as NSString)
                        }
                    }
                }
            })
        }
    }

}
