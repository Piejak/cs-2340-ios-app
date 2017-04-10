//
//  WaterReportListViewController.swift
//  WaterReport
//
//  Created by Hui Li on 4/1/17.
//  Copyright © 2017 Brian Piejak. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class WaterReportListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var reportListTable: UITableView!
    
    var reports = [WaterSourceReport] ()
    override func viewDidLoad() {
        self.reportListTable.delegate = self
        self.reportListTable.dataSource = self
        super.viewDidLoad()
        fillList()
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        fillList()
//
//    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createReport(_ sender: AnyObject) {
        let waterReportVC = storyboard?.instantiateViewController(withIdentifier: "WaterSourceReport")
        self.navigationController?.pushViewController(waterReportVC!, animated: true)
    }
    
    
    func fillList() {
        FIRDatabase.database().reference().child("WaterSourceReport").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let report = WaterSourceReport()
                report.location = (dictionary["location"] as? [AnyHashable : Any]?)!
                report.date = dictionary["date"] as! String?
                report.reporter = dictionary["reporter"] as! String?
                report.reportNumber = dictionary["reportNumber"] as! Int?
                report.waterCondition = dictionary["waterCondition"] as! String?
                report.waterType = dictionary["waterType"] as! String?
                self.reports.append(report)
                self.reportListTable.reloadData()
            }
            
        })
    }
    
    func tableView(_ tableview: UITableView,  numberOfRowsInSection section: Int) -> Int
    {
        return  self.reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .default, reuseIdentifier: "WaterSourceReport")
        let report = self.reports[indexPath.row]
        let number = String(report.reportNumber!)
        cell.textLabel?.text = number
        return cell
    }
    
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let vcName = "WaterTypeTable"
//            let viewController = storyboard?.instantiateViewController(withIdentifier: vcName) as! WaterTypeTableViewController
//            viewController.waterTypeDelegate = self
//            self.navigationController?.pushViewController(viewController, animated: true)
//     }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
