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
    
    
    @IBOutlet weak var UserEmailLabel: UILabel!
    
    @IBOutlet weak var userNewPassword: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userAge: UITextField!
    @IBOutlet weak var userAffiliation: UITextField!
    @IBOutlet weak var uerAddress: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserProfile()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showUserProfile() {
        if let user = FIRAuth.auth()?.currentUser {
            userName.text = user.displayName
            print(user.displayName)
            UserEmailLabel.text = user.email
            // Do NOT use this value to authenticate with
            // your backend server, if you have one.Use
            // getTokenWithCompletion:completion: instead.
        } else {
            // No user is signed in.
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
