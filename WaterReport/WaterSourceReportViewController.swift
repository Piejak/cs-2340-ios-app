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


protocol WaterTypeProtocol {
    func setResultOfWaterType(valueSent: String)
}
protocol WaterconditionProtocol {
    func setResultOfWaterWaterCondition(valueSent: String)
}
class WaterSourceReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,WaterTypeProtocol, WaterconditionProtocol{
    
    internal func setResultOfWaterType(valueSent: String) {
        self.typeDefaultValue = valueSent
        print(typeDefaultValue)
    }
    
    internal func setResultOfWaterWaterCondition(valueSent: String) {
        self.conditionDefaultValue = valueSent
        print(typeDefaultValue)
    }

    var typeDefaultValue: String = "Default"
    var conditionDefaultValue: String = "Default"
    var valueSentFromWaterTypeViewController:String?
    var valueSentFromWaterConditionViewController:String?
    var reportNumber: Int = 0
    
    
    @IBOutlet weak var typeTableView: UITableView!
    @IBOutlet weak var conditionTableView: UITableView!
    @IBOutlet weak var LongitudeTextView: UITextField!
    @IBOutlet weak var LatitudeTextView: UITextField!
    var typeList:[String] = ["Water Type"]
    var ConditionList:[String] = ["Water Condition"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.typeTableView.delegate = self
        self.typeTableView.dataSource = self
        self.conditionTableView.delegate = self
        self.conditionTableView.dataSource = self
        self.typeTableView.separatorStyle = .none
        self.conditionTableView.separatorStyle = .none
        typeList[0] = typeDefaultValue
        ConditionList[0] = conditionDefaultValue
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        typeList[0] = typeDefaultValue
        ConditionList[0] = conditionDefaultValue
        self.typeTableView.reloadData()
        self.conditionTableView.reloadData()
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
            let vcName = "WaterTypeTable"
            let viewController = storyboard?.instantiateViewController(withIdentifier: vcName) as! WaterTypeTableViewController
            viewController.waterTypeDelegate = self
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let vcName = "WaterConditionTable"
            let viewController = storyboard?.instantiateViewController(withIdentifier: vcName) as! WaterConditionTableViewController
            viewController.waterConditionDelegate = self
            self.navigationController?.pushViewController(viewController, animated: true)
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
        
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                if let reportNum = dictionary["reportNo"] as? Any {
                    self.reportNumber = reportNum as! Int
                    self.reportNumber = self.reportNumber + 1
                }
            }
        })
        
        let reportInfo = ["Location": reportLocation.toArray(), "Date": dateString, "reporter": uid, "waterCondition": conditionDefaultValue, "waterType": typeDefaultValue, "ReportNumber" : self.reportNumber + 1] as [String : Any]
        ref.child("reportNo").setValue(reportNumber + 1)
        ref.child("WaterSourceReport").childByAutoId().setValue(reportInfo)
        
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
