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
    
    @IBOutlet weak var typeTableView: UITableView!
    @IBOutlet weak var conditionTableView: UITableView!
    
    var typeList:[String] = ["Water Type"]
    var ConditionList:[String] = ["Water Condition"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.typeTableView.delegate = self
        self.typeTableView.dataSource = self
        self.conditionTableView.delegate = self
        self.conditionTableView.dataSource = self
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
        let ref = FIRDatabase.database().reference()
        let vcName = accountType[indexPath.row]
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if let result = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for child in result {
                    var userKey = child.key
                    ref.child("users").child(userKey).child("AccountType").setValue(vcName)
                    let ProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC")
                    self.navigationController?.pushViewController(ProfileVC!, animated: false)
                }
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
