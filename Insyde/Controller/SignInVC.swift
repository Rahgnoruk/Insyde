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

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: SignInTextField!
    @IBOutlet weak var passwordField: SignInTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            }
        })
    }
    
    @IBAction func SignInBtnTap(_ sender: AnyObject) {
        if let email = emailField.text, let pwd = passwordField.text{
            //Intentar ingresar, si funciona significa que ya tenia cuenta
            Auth.auth().signIn(withEmail: email, password: pwd, completion: {(user, error) in
                if(error == nil){
                    print("JESS: Email user authenticated with Firebase")
                }else{
                    //Ya que no tiene cuenta, crear cuenta
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: {(user, error) in
                        if error != nil{
                            print("JESS: Unable to authenticate with Firebase using mail")
                        }else{
                            print("JESS: Successfully authenticated with Firebase using mail");
                        }
                    })
                }
            })
            
        }
    }
}

