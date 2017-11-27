//
//  InterfaceController.swift
//  InsydeWatch Extension
//
//  Created by user132086 on 11/26/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import WatchKit
import Foundation




class InterfaceController: WKInterfaceController {
    //@IBOutlet var labelOut: WKInterfaceLabel!
    
    
    @IBAction func passTop() {
        print("Top 5")
        pushController(withName: "SecondInterface", context: 1)
    }
    
    @IBAction func passNew() {
        print("Newest 5")
        pushController(withName: "SecondInterface", context: 0)
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
    }
    
    
}
