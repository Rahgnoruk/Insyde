//
//  DesplegarPublicacionVC.swift
//  Insyde
//
//  Created by user132086 on 11/26/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import UIKit

class DesplegarPublicacionVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var publicacion: String = "gs://insyde-aca27.appspot.com/Articulos/Noticias/PDFs/CondicionMigratoriaAyucanPDF.pdf"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let pdfUrl = NSURL(string: publicacion)
        let req = NSURLRequest(url: pdfUrl! as URL)
        webView.loadRequest(req as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
