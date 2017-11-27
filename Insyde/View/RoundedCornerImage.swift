//
//  RoundedCornerImage.swift
//  Insyde
//
//  Created by user132086 on 11/26/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import UIKit

class ShadowRoundedImage: UIImageView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
     layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
     layer.shadowOpacity = 0.8
     layer.shadowRadius = 5.0
     layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
     layer.cornerRadius = 2.0;
    }
    
    

}
