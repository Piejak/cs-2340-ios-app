//
//  MapViewController.swift
//  WaterReport
//
//  Created by Hui Li on 4/2/17.
//  Modified by Yudong Shao
//  Copyright © 2017 Brian Piejak. All rights reserved.
//

import UIKit
import GoogleMaps

import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import Firebase

import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    var reports = [WaterSourceReport] ()
    var ref: FIRDatabaseReference!
    var refh: UInt!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //updateData()
        
        FIRDatabase.database().reference().child("WaterSourceReport").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                var report = WaterSourceReport()
                report.location = (dictionary["location"] as? [AnyHashable : Any]?)!
                
                report.date = dictionary["date"] as! String?
                report.reporter = dictionary["reporter"] as! String?
                report.reportNumber = dictionary["reportNumber"] as! Int?
                
                
                report.waterCondition = dictionary["waterCondition"] as! String?
                report.waterType = dictionary["waterType"] as! String?
                
                var lo = report.location[AnyHashable("Longitude")]! as! Double
                var la = report.location[AnyHashable("Latitude")]! as! Double
                var num = String(report.reportNumber)
                var location = CLLocationCoordinate2DMake(lo, la)
                var annotation = MKPointAnnotation()
                
                annotation.coordinate = location
                annotation.title = "reporter : " + report.reporter + "; report Number: " + " " + num + "; Date: " + report.date
                
                annotation.subtitle = "Water Type" + report.waterType + "; Water Condition: " + report.waterCondition
                
                self.map.addAnnotation(annotation)
                self.reports.append(report)
                
                var size = self.reports.count
                print(size)
                
                /*var i = 0
                while (i < size - 1) {
                    var lo = self.reports[i].location[AnyHashable("Longitude")]! as! Double
                    var la = self.reports[i].location[AnyHashable("Latitude")]! as! Double
                    
                    var num = String(self.reports[i].reportNumber)
                    var location = CLLocationCoordinate2DMake(lo, la)
                    var annotation = MKPointAnnotation()
                    
                    annotation.coordinate = location
                    
                    
                    
                    
                    
                    
                    annotation.title = "reporter : " + self.reports[i].reporter + "; report Number: " + " " + num + "; Date: " + self.reports[i].date
                    
                    annotation.subtitle = "Water Type" + self.reports[i].waterType + "; Water Condition: " + self.reports[i].waterCondition
                    
                    self.map.addAnnotation(annotation)
                    i = i + 1
                }*/

                
            }
        })

        
        /*let size = self.reports.count
        print(size)
        /*for index in 0...size {
            var lo = self.reports[index].location[AnyHashable("Longitude")] as! Double
            //var long = Double(lo)
            var la = self.reports[index].location[AnyHashable("Latitude")] as! Double
            
            var location = CLLocationCoordinate2DMake(la, lo)
            
            var annotation = MKPointAnnotation()
            
            annotation.coordinate = location
            
            var num =  self.reports[index].reportNumber as! String
            annotation.title = "reporter : " + self.reports[index].reporter + "; report Number: " + num + "; Date: " + self.reports[index].date
            
            annotation.subtitle = "Water Type" + reports[index].waterType + "; Water Condition: " + reports[index].waterCondition
            
            map.addAnnotation(annotation)
            
            
            
            
            
            
            
            
            
            
        }*/
        
        /*if (size > 0) {
            for i in 0...size - 1 {
                let lo = self.reports[i].location[AnyHashable("Longitude")]! as! Double
                let la = self.reports[i].location[AnyHashable("Latitude")]! as! Double
                
                let location = CLLocationCoordinate2DMake(la, lo)
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = location
                
                
                
                //var num =  self.reports[index].reportNumber as! String
                //var num =  self.reports[index].reportNumber
                annotation.title = "reporter : " + self.reports[i].reporter + "; report Number: " + " " + String(i) + "; Date: " + "4/8"
                
                annotation.subtitle = "Water Type" + "lake" + "; Water Condition: " + "hi"
                
                map.addAnnotation(annotation)
            }

        }*/
        var i = 0
        while (i < size - 1) {
            let lo = self.reports[i].location[AnyHashable("Longitude")]! as! Double
            let la = self.reports[i].location[AnyHashable("Latitude")]! as! Double
            
            let num = String(self.reports[i].reportNumber)
            let location = CLLocationCoordinate2DMake(lo, la)
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = location
            
            
            
            
            
           
            annotation.title = "reporter : " + self.reports[i].reporter + "; report Number: " + " " + num + "; Date: " + self.reports[i].date
            
            annotation.subtitle = "Water Type" + self.reports[i].waterType + "; Water Condition: " + self.reports[i].waterCondition
            
            map.addAnnotation(annotation)
            i = i + 1
        }*/
        
        
        
        
        
        /*GMSServices.provideAPIKey("AIzaSyCuBhjKyEAGAtC_ZMkKcVrnWg1xqtYOUmQ")
        
        let camera = GMSCameraPosition.camera(withLatitude: 1.285, longitude: 103.848, zoom: 12)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView*/
        
        // Do any additional setup after loading the view.
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData() {
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
                
            }
        })
    }
    
    func naData() {
        ref = FIRDatabase.database().reference()
        refh = ref.observe(FIRDataEventType.value, with: {(snapshot) in
            let dictionary = snapshot.value as? [String: AnyObject]
            let report = WaterSourceReport()
            report.location = (dictionary!["location"] as? [AnyHashable : Any]?)!
            report.date = dictionary!["date"] as! String?
            report.reporter = dictionary!["reporter"] as! String?
            report.reportNumber = dictionary!["reportNumber"] as! Int?
            report.waterCondition = dictionary!["waterCondition"] as! String?
            report.waterType = dictionary!["waterType"] as! String?
            self.reports.append(report)
        
        
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
