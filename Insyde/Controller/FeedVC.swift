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
    @IBOutlet weak var cameraButton: CircleView!
    @IBOutlet weak var titleField: UITextField!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot{
                    print("SNAP: \(snap)")
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
            
            if let img = FeedVC.imageCache.object(forKey: post.pdfURL as NSString){
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            cameraButton.image = image
            imageSelected = true
        }else{
            print("JESS: A valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func uploadButtonTapped(_ sender: Any) {
        //guard hace el if siguiente, qe se asegura de que no este vacio
        guard let title = titleField.text, title != "" else{
            print("JESS: Title field is empty")
            return //es mas parecido a un break que un return tradicional
        }
        guard let img = cameraButton.image, imageSelected else{
            print("JESS: An image must be selected")
            return
        }
        if let imgData = UIImageJPEGRepresentation(img, 0.2){
            let imageUid = NSUUID().uuidString
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            DataService.ds.REF_POST_IMAGES.child(imageUid).putData(imgData, metadata: metaData){ (metadata, error) in
                if error != nil{
                    print("JESS: Unable to upload image to Storage")
                }else{
                    print("Successfully uploaded image to Storage")
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                }
            }
        }
    }
    
    @IBAction func SignOutTap(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("JESS: ID removed from keychain \(keychainResult)")
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
}
