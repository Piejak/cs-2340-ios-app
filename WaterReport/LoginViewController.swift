//
//  LoginViewController.swift
//  WaterReport
//
//  Created by Hui Li on 2/26/17.
//  Copyright © 2017 Brian Piejak. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

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
    
    
    
    @IBAction func login(_ sender: AnyObject) {
        FIRAuth.auth()?.signIn(withEmail:Email.text!, password: Password.text!, completion: {
                user, error in
                if error != nil {
                    print("Incorrect")
                }
                    
                else {
                  self.performSegue(withIdentifier: "LoginToProfile", sender: nil)
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
