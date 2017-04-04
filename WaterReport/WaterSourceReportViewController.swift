//
//  WaterSourceReportViewController.swift
//  WaterReport
//
//  Created by Hui Li on 3/26/17.
//  Copyright © 2017 Brian Piejak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth


class WaterSourceReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var typeDefaultValue: String = "Default"
    var conditionDefaultValue: String = "Default"
    
    var waterType: String {
        get {
            return typeDefaultValue
        }
        set {
            typeDefaultValue = newValue
        }
    }
    
    var waterCondition: String {
        
        get {
            return conditionDefaultValue
        }
        set {
            conditionDefaultValue = newValue
        }
    }
    
    @IBOutlet weak var typeTableView: UITableView!
    @IBOutlet weak var conditionTableView: UITableView!
    @IBOutlet weak var LongitudeTextView: UITextField!
    @IBOutlet weak var LatitudeTextView: UITextField!
    var typeList:[String] = ["Water Type"]
    var typeIdentities:[String] = ["WaterTypeTable"]
    var ConditionList:[String] = ["Water Condition"]
    var conditionIdentities:[String] = ["WaterConditionTable"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.typeTableView.delegate = self
        self.typeTableView.dataSource = self
        self.conditionTableView.delegate = self
        self.conditionTableView.dataSource = self
        self.typeTableView.separatorStyle = .none
        self.conditionTableView.separatorStyle = .none
        typeList[0] = waterType
        ConditionList[0] = waterCondition
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tableView == self.typeTableView) ?
         typeList.count : ConditionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if (tableView == self.typeTableView) {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "WaterType")
            cell.textLabel?.text = typeList[indexPath.row]
            return cell
        }else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "WaterCondition")
            cell.textLabel?.text = ConditionList[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == self.typeTableView) {
            let vcName = typeIdentities[indexPath.row]
            let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
            self.navigationController?.pushViewController(viewController!, animated: true)
        } else {
            let vcName = conditionIdentities[indexPath.row]
            let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
    }
    
    
    
    @IBAction func CreateWaterReport(_ sender: AnyObject) {
        
        let reportLatitude = Double(LatitudeTextView.text!)
        let reportLongitude = Double(LongitudeTextView.text!)
        let reportLocation = Location(latitude: reportLatitude!, longitude: reportLongitude!)
        let currentDateTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: currentDateTime)
        let user = FIRAuth.auth()?.currentUser
        let uid = user?.uid
        let ref = FIRDatabase.database().reference()
        let reportInfo = ["Location": reportLocation.toArray(), "Date": dateString, "reporter": uid, "waterCondition": "Default", "waterType": "Default",] as [String : Any]
        ref.child("report").childByAutoId().setValue(reportInfo)
        
    }
    
//        @IBAction func CreateAccount(_ sender: AnyObject) {
//        FIRAuth.auth()?.createUser(withEmail: Email.text!, password: Password.text!, completion: {
//        user, error in
//        
//        if error != nil {
//        self.login()
//        print("Wrong")
//        }
//        else {
//        print("User Created")
//        let ref = FIRDatabase.database().reference()
//        let userInfo = ["Email": user?.email, "Name": "", "Age": "", "Address": "", "Affiliation": "", "AccountType": AccountType.Default.rawValue, "uid": user?.uid]
//        ref.child("users").childByAutoId().setValue(userInfo)
//        self.login()
//        }
//        })
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
