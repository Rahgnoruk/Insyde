//
//  PostCell.swift
//  Insyde
//
//  Created by user132086 on 11/2/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var texto: UITextView!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post, img: UIImage? = nil){
        self.post = post
        self.texto.text = post.autores
        self.title.text = post.titulo
        
        if img != nil{
            print("JESS: Image passed from view")
            self.imagen.image = img
        }else{
            let ref = Storage.storage().reference(forURL: post.pdfURL)
            ref.getData(maxSize: 2*1024*1024, completion: {(data, error) in
                if error != nil{
                    print("JESS: Unable to download image from storage")
                }else{
                    print("JESS: Image downloaded from Storage")
                    if let imgData = data{
                        if let img = UIImage(data: imgData){
                            self.imagen.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.pdfURL as NSString)
                        }
                    }
                }
            })
        }
    }
}
