//
//  RegisterViewController.swift
//  WaterReport
//
//  Created by HUI Li on 2/26/17.
//  Copyright © 2017 Brian Piejak. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RegisterViewController: UIViewController {

    @IBOutlet weak var Email: UITextField!
    
    
    @IBOutlet weak var Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
    @IBAction func CreateAccount(_ sender: AnyObject) {
        FIRAuth.auth()?.createUser(withEmail: Email.text!, password: Password.text!, completion: {
            user, error in
            
            if error != nil {
                self.login()
                print("Wrong")
            }
            else {
                print("User Created")
                let ref = FIRDatabase.database().reference()
                let userInfo = ["Email": user?.email, "Name": "", "Age": "", "Address": "", "Affiliation": "", "AccountType": AccountType.Default.rawValue, "uid": user?.uid]
                ref.child("users").childByAutoId().setValue(userInfo)
                self.login()
            }
        })
    }
    
    
    func login() {
        FIRAuth.auth()?.signIn(withEmail:Email.text!, password: Password.text!, completion: {
            user, error in
            
            if error != nil {
                print("Incorrect")
            }
        })
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
