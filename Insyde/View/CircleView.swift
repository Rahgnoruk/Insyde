//
//  CircleView.swift
//  Insyde
//
//  Created by user132086 on 11/2/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    //Jess quita el awake porque no le gusto la sombra
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
   
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width/2
    }
    
    /*
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = self.frame.width/2;
        //el agrega esto
        //clipsToBounds = true
    }
 */
}
