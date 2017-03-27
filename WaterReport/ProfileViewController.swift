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

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var AgeField: UITextField!
    @IBOutlet weak var AddressField: UITextField!
    @IBOutlet weak var AffiliationField: UITextField!
    
    var email: String?
    var realName: String?
    var affiliation: String?
    var accountType: AccountType?

    
    
    var mylist:[String] = ["Account Type"]
    var identities:[String] = ["A"]
    
    var ref:FIRDatabaseReference?
    
    
    @IBOutlet weak var myTextField: UITextField!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        if let user = FIRAuth.auth()?.currentUser {
            let email = user.email
            self.EmailField.text = email
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with
            // your backend server, if you have one.Use
            // getTokenWithCompletion:completion: instead.
        } else {
            // No user is signed in.
        }
        
        ref?.child("users").queryOrderedByKey().observeSingleEvent(of:.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let name = dictionary["Name"] as? String
                self.NameField.text = name
                let age = dictionary["Age"] as? String
                self.AgeField.text = age
                let address = dictionary["Address"] as? String
                self.AddressField.text = address
                let affiliation = dictionary["Affiliation"] as? String
                self.AffiliationField.text = affiliation
            }
        })
        
        // Do any additional setup after loading the view.
    }
    
    
    
     func tableView(_ tableview: UITableView,  numberOfRowsInSection section: Int) -> Int
    {
        return mylist.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        ref?.child("users").queryOrderedByKey().observeSingleEvent(of:.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {

                let accountType = dictionary["AccountType"] as? String
                cell.textLabel?.text = accountType
            }
        })
        // todo the font size
//        cell.textLabel?.font = [ UIFont .boldSystemFont(ofSize: 16)];
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcName = identities[indexPath.row]
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    
    
    @IBAction func ChangeProfile(_ sender: AnyObject) {
        ref = FIRDatabase.database().reference()
        let name: String? = NameField.text
        ref?.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if let result = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for child in result {
                    var userKey = child.key as! String
                        self.ref?.child("users").child(userKey).child("Name").setValue(name)
                }
            }
        })
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
