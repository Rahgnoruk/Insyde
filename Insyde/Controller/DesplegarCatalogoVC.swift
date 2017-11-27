//
//  DesplegarCatalogoVC.swift
//  Insyde
//
//  Created by user132086 on 11/25/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import UIKit
import Firebase

class DesplegarCatalogoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var catalogo: String = "Noticias"
    var publicacionModels = [PublicacionModel]()
    
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.title = catalogo
        // Do any additional setup after loading the view.
        DataService.ds.REFS[catalogo]!.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot{
                    print("SNAP: \(snap)")
                    if let postDic = snap.value as? Dictionary<String, Any>{
                        let id = snap.key
                        let publicacion = PublicacionModel(publicacionId: id, postData: postDic)
                        self.publicacionModels.append(publicacion)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return publicacionModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let publicacionModel = publicacionModels[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PublicacionCell") as? PublicacionCell{
            
            if let img = DesplegarCatalogoVC.imageCache.object(forKey: publicacionModel.pdfURL as NSString){
                cell.configureCell(publicacionModel: publicacionModel, img: img)
                return cell
            }else{
                cell.configureCell(publicacionModel: publicacionModel)
                return cell
            }
            
        }else{
            return PublicacionCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indice = indexPath.row
        let publicacionSeleccionada = publicacionModels[indice]
        let siguienteVista = self.storyboard?.instantiateViewController(withIdentifier: "DesplegarPublicacion") as! DesplegarPublicacionVC
        
        siguienteVista.publicacion = publicacionSeleccionada.pdfURL
        performSegue(withIdentifier: "mostrarPublicacion", sender: publicacionSeleccionada)//Esto llama prepareforsegue
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let publicacionSeleccionada = sender as? PublicacionModel{
            if let siguienteVista = segue.destination as? DesplegarPublicacionVC{
                siguienteVista.publicacion = publicacionSeleccionada.pdfURL
            }
        }
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
