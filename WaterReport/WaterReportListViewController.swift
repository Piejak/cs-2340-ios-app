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
        let nib = UINib(nibName: "ListCellTableViewCell", bundle: nil)
        self.reportListTable.register(nib, forCellReuseIdentifier: "ListCellTableViewCell")
//        self.reportListTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        self.reportListTable.register(UINib?, forHeaderFooterViewReuseIdentifier: <#T##String#>)
//        self.reportListTable.register(UINib(nibName: "MyCustomTableCell", bundle: nil), forCellReuseIdentifier: "customCell")
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
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "WaterSourceReport") as! CustomTableViewCell
        let cell: ListCellTableViewCell = self.reportListTable.dequeueReusableCell(withIdentifier: "ListCellTableViewCell", for: indexPath) as! ListCellTableViewCell
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "listCell")
//        let cell = Bundle.main.loadNibNamed("CustomTableViewCell", owner: self, options: nil) as! CustomTableViewCell
        let report = self.reports[indexPath.row]
        cell.numberLabel.text = String(report.reportNumber)
        cell.dateLabel.text = report.date
//        cell.latitudeLabel.text = report.location.
//        cell.longitudeLabel.text = report.location[1]
        cell.waterConditionLabel.text = report.waterCondition
        cell.waterTypeLabel.text = report.waterType
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
