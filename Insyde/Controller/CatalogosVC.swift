//
//  ArticlesVC.swift
//  Insyde
//
//  Created by user132086 on 11/18/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class CatalogosVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    
    //Build from firebase
    var catalogModels = [CatalogModel]()
    
    //Search
    var catalogosFiltrados = [CatalogModel]()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CatalogosVC.SignOutTap(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //Paso 6: usar la vista actual para presentar los resultados de la búsqueda
        searchController.searchResultsUpdater = self
        //paso 7: controlar el background de los datos al momento de hacer la búsqueda
        searchController.dimsBackgroundDuringPresentation = false //Desactiva todo menos la barra de busqueda
        //Paso 8: manejar la barra de navegación durante la busuqeda (la que tiene "Back")
        searchController.hidesNavigationBarDuringPresentation = false
        //Paso 9: Definir el contexto de la búsqueda
        definesPresentationContext = true
        //Paso 10: Instalar la barra de búsqueda en la cabecera de la tabla
        tableView.tableHeaderView = searchController.searchBar
        
        DataService.ds.REF_CATALOGOS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot{
                    if let catalogName = snap.value as? String{
                        print("TONY: Catalogo: \(catalogName)")
                        let catalogModel = CatalogModel(nombre: catalogName)
                        self.catalogModels.append(catalogModel)
                    }
                }
            }
            self.catalogosFiltrados = self.catalogModels
            self.tableView.reloadData()
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        
        // si la caja de búsuqeda es vacía, entonces mostrar todos los resultados
        if searchController.searchBar.text! == "" {
            catalogosFiltrados = catalogModels
        } else {
            // Filtrar los resultados de acuerdo al texto escrito en la caja que es obtenido a través del parámetro $0
            catalogosFiltrados = catalogModels.filter {
                let catalogo=$0.nombre;
                return(catalogo.lowercased().contains(searchController.searchBar.text!.lowercased()))
                
            }
        }
        
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return catalogosFiltrados.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let catalogModel = catalogosFiltrados[indexPath.row]
        
        if let catalogCell = tableView.dequeueReusableCell(withIdentifier: "CatalogCell") as? CatalogCell{
            catalogCell.configureCell(model: catalogModel)
            return catalogCell
        }else{
            return CatalogCell()
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var indice = 0
        var catalogoSeleccionado = CatalogModel(nombre: "SeleccionFallida");
        let siguienteVista = self.storyboard?.instantiateViewController(withIdentifier: "DesplegarCatalogo") as! DesplegarCatalogoVC
        print("\(siguienteVista.catalogo)")
        indice = indexPath.row
        
        catalogoSeleccionado = catalogosFiltrados[indice]
        let s:String = catalogoSeleccionado.nombre
        print("\(s)")
        siguienteVista.catalogo = s
        print("\(siguienteVista.catalogo)")
        performSegue(withIdentifier: "mostrarCatalogo", sender: catalogoSeleccionado)//Esto llama prepareforsegue
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let catalogoSeleccionado = sender as? CatalogModel{
            if let siguienteVista = segue.destination as? DesplegarCatalogoVC{
                siguienteVista.catalogo = catalogoSeleccionado.nombre
            }
        }
    }
    @IBAction func SignOutTap(sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("JESS: ID removed from keychain \(keychainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
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
