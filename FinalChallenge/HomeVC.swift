//
//  HomeVC.swift
//  FinalChallenge
//
//  Created by Jansen Malvin on 18/01/19.
//  Copyright © 2019 Terretino. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import GoogleSignIn

class HomeVC: UIViewController {
    @IBOutlet weak var emailLBL: UILabel!
    @IBOutlet weak var createFamView: UIView!
        @IBOutlet weak var famNameTF: UITextField!
    
    
    let MasterUser = Auth.auth().currentUser?.uid as! String
    let userEmail = Auth.auth().currentUser?.email
    let userDefault = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailLBL.text = userEmail
        createFamView.isHidden = true
    }
    
    @IBAction func createFam(_ sender: Any) {
        createFamView.isHidden = false
    }
    
    
    @IBAction func createFamViewAct(_ sender: Any) {
        let userRef : DocumentReference = Firestore.firestore().document("user-collection/\(MasterUser)")
        
        let dict : [String: Any] = ["family-name" : famNameTF.text, "family-member" : [userRef]]
        //Firestore.firestore().collection("family-collection").addDocument(data: dict)
        
        let dict2 : [String: Any] = ["family-array" : [Firestore.firestore().collection("family-collection").addDocument(data: dict)]]
        Firestore.firestore().collection("user-collection").document(MasterUser).setData(dict2)
        
        
        createFamView.isHidden = true
    }
    
    
    @IBAction func signOutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            try GIDSignIn.sharedInstance()?.signOut()
            userDefault.removeObject(forKey: "usersignedin")
            userDefault.synchronize()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            print (signOutError.localizedDescription)
        }
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
