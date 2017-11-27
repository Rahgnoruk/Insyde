//
//  ViewController.swift
//  Insyde
//
//  Created by user132086 on 10/30/17.
//  Copyright © 2017 TonyfiedProductions. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: SignInTextField!
    @IBOutlet weak var passwordField: SignInTextField!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool){
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    
    @IBAction func facebookBtnTap(_ sender: AnyObject) {
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self){ (result, error) in
            if error != nil{
                print("JESS: Unable to authenticate with Facebook - \(String(describing: error))")
            }else if result?.isCancelled == true{
                print("JESS: User cancelled Facebook authentication")
            }else{
                print("JESS: Successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth((credential))
            }
        }
    }
    func firebaseAuth(_ credential: AuthCredential){
        Auth.auth().signIn(with: credential, completion: {(user, error) in
            if error != nil{
                print("JESS: Unable to authenticate with Firebae - \(String(describing: error))")
            }else{
                print("JESS: Successfully authenticated with Firebase")
                if let user=user{
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
            }
        })
    }
    
    @IBAction func SignInBtnTap(_ sender: AnyObject) {
        if let email = emailField.text, let pwd = passwordField.text{
            //Intentar ingresar, si funciona significa que ya tenia cuenta
            Auth.auth().signIn(withEmail: email, password: pwd, completion: {(user, error) in
                if(error == nil){
                    print("JESS: Email user authenticated with Firebase")
                    if let user=user{
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                }else{
                    //Ya que no tiene cuenta, crear cuenta
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: {(user, error) in
                        if error != nil{
                            print("JESS: Unable to authenticate with Firebase using mail")
                        }else{
                            print("JESS: Successfully authenticated with Firebase using mail");
                            if let user=user{
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
    func completeSignIn(id: String, userData: Dictionary<String, String>){
        DataService.ds.createFirebaseUser(uid: id, userData: userData)
        let result = KeychainWrapper.standard.set(id, forKey: KEY_UID);
        print("JESS: Data saved to keychain \(result)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
}

