//
//  FeedVC.swift
//  Insyde
//
//  Created by user132086 on 11/2/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImageButton: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        
        DataService.ds.REF_DENUNCIAS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot{
                    if let postDic = snap.value as? Dictionary<String, Any>{
                        let id = snap.key
                        let post = Post(postId: id, postData: postDic)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell{
            
            if let img = FeedVC.imageCache.object(forKey: post.imgURL as NSString){
                cell.configureCell(post: post, img: img)
                return cell
            }else{
                cell.configureCell(post: post)
                return cell
            }
 
        }else{
            return PostCell()
 
        }
    }
    
    @IBAction func cameraButton(_ sender: Any){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraDevice = UIImagePickerControllerCameraDevice.rear
            present(imagePicker, animated: true, completion: nil)
        }else{
            print("Rear camera not available")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            addImageButton.image = image
            imageSelected = true
        }else{
            print("TONY: A valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addImageButtonTapped(_ sender: Any) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func uploadButtonTapped(_ sender: Any) {
        //guard hace el if siguiente, qe se asegura de que no este vacio
        guard let titulo = titleField.text, titulo != "" else{
            print("TONY: Title field is empty")
            return //es mas parecido a un break que un return tradicional
        }
        guard let img = addImageButton.image, imageSelected else{
            print("TONY: An image must be selected")
            return
        }
        guard let descripcion = descriptionField.text, descripcion != "" else{
            print("TONY: Description field is empty")
            return //es mas parecido a un break que un return tradicional
        }
        if let imgData = UIImageJPEGRepresentation(img, 0.2){
            let imageUid = NSUUID().uuidString
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            DataService.ds.REF_POST_IMAGES.child(imageUid).putData(imgData, metadata: metaData){ (metadata, error) in
                if error != nil{
                    print("TONY: Unable to upload image to Storage")
                }else{
                    print("Successfully uploaded image to Storage")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    if let url = downloadURL{
                        self.postToFirebase(imgUrl: url)
                    }
                }
            }
        }
    }
    
    func postToFirebase(imgUrl: String){
        let post: Dictionary<String, Any> = [
            "titulo": titleField.text!,
            "descripcion": descriptionField.text!,
            "imgURL": imgUrl,
            "bumps": 1
        ]
        
        let firebasePost = DataService.ds.REF_DENUNCIAS.childByAutoId()
        firebasePost.setValue(post)
        
        titleField.text = ""
        descriptionField.text = ""
        imageSelected = false
        addImageButton.image = UIImage(named:"add-Post")
    }
    
    @objc func SignOutTap(sender: UIBarButtonItem) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("TONY: ID removed from keychain \(keychainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
}
