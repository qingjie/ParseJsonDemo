//
//  DetailViewController.swift
//  ParseJsonDemo
//
//  Created by qingjiezhao on 6/10/15.
//  Copyright (c) 2015 qingjiezhao. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController , CLLocationManagerDelegate {

    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var detailItem = [String : String]()

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    var lat = String()
    var lon = String()
    var tempName = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(detailItem)
        
        for key in detailItem.keys{
            println(key)
            if key == "name" {
                tempName = detailItem["name"]!
                lblName.text = tempName
            }else if key == "address" {
                lblAddress.text = detailItem["address"]
            }else if key == "latitudeData" {
                lat = detailItem["latitudeData"]!
            }else if key == "longitudeData" {
                lon = detailItem["longitudeData"]!
            }else{
                
            }
        }
        
        println("========detail======")
        loadMap(lat,lon: lon,name: tempName)
        
        println("lat\(lat)")
        println("lon\(lon)")
        println("tempName\(tempName)")
    }
    
    
    func loadMap(lat:String,lon:String,name:String){
        var dLat = (lat as NSString).doubleValue
        var dLon = (lon as NSString).doubleValue
        var location = CLLocationCoordinate2DMake(dLat , dLon)
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = name
        annotation.subtitle = "USA"
        
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickImge(sender: AnyObject) {
        
    }
    
    //unwind
    @IBAction func close(segue: UIStoryboardSegue) {
        println("closed")
    }
    

    @IBAction func callTapped(sender: AnyObject) {
        callNumber("3154161144")
    }
    
    func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string:"tel://"+"\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    


}

