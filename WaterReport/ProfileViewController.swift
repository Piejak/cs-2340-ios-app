//
//  ProfileViewController.swift
//  WaterReport
//
//  Created by Hui Li on 2/26/17.
//  Copyright © 2017 Brian Piejak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userNewPassword: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userAge: UITextField!
    @IBOutlet weak var userAffiliation: UITextField!
    @IBOutlet weak var uerAddress: UITextField!
    
    
    var dataBaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef : FIRStorage {
        return FIRStorage.storage()
    }
    
    func loadUserInfo() {
        let userRef = dataBaseRef.child("users/\(FIRAuth.auth()?.currentUser!.uid)")
        userRef.observe(.value, with: {(snapshot) in
            let user = User(snapshot: snapshot)
            self.userName.text = user.realname
            self.userAge.text = String(describing: user.age)
            self.userAffiliation.text = user.affiliation
            
        }) { (error) in
            print(error.localizedDescription)
            
        }
    }
     
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadUserInfo()

        // Do any additional setup after loading the view.
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
