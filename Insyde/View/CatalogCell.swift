//
//  CatalogCell.swift
//  Insyde
//
//  Created by user132086 on 11/25/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import UIKit

class CatalogCell: UITableViewCell {

    @IBOutlet weak var cellText: UILabel!
    
    
    var catalogModel: CatalogModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model: CatalogModel){
        self.catalogModel = model
        self.cellText.text = model.nombre
    }
}
