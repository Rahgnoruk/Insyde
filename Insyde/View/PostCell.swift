//
//  PostCell.swift
//  Insyde
//
//  Created by user132086 on 11/2/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var texto: UITextView!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post){
        self.post = post
        self.texto.text = post.autores
        self.title.text = post.titulo
        //self.imagen.image = post.pdfURL
    }
}
