//
//  LoginVC.swift
//  FinalChallenge
//
//  Created by Jansen Malvin on 18/01/19.
//  Copyright © 2019 Terretino. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


class LoginVC: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    let userDefault = UserDefaults.standard
    var GIDSignUp = Bool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.uiDelegate = self
    }
 
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            guard error == nil else {
                if error?._code == AuthErrorCode.userNotFound.rawValue {
                    print("User Belum Terdaftar")
                } else {
                    //AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                    print(error)
                    print(error?.localizedDescription)
                }
                return
            }
            if error == nil {
                print("BERHASIL SIGN IN")
                self.userDefault.set(true, forKey: "usersignedin")
                self.userDefault.synchronize()
                self.performSegue(withIdentifier: "Login-Home", sender: self)
            }
        })
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        guard let email = emailTF.text,
            email != "",
            let password = passwordTF.text,
            password != ""
            else {
                print("please fill textfield")
                //AlertController.showAlert(self, title: "Missing Info", message: "Please fill out all required fields")
                return
        }
        signIn(email: emailTF.text!, password: passwordTF.text!)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
