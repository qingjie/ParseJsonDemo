//
//  MasterViewController.swift
//  ParseJsonDemo
//
//  Created by qingjiezhao on 6/10/15.
//  Copyright (c) 2015 qingjiezhao. All rights reserved.
//


import UIKit


class MasterViewController: UITableViewController {
    
    var objects = [[String : String]]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlString : String = "http://www.ruebarue.com/api/search?types=attraction&destination=boston"
        
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)) { [unowned self] in
            if let url = NSURL(string: urlString){
                if let data = NSData(contentsOfURL: url, options: .allZeros, error: nil){
                    //let json = JSON( data: data)
                    let json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)! as! NSArray
                    self.parseJSON(json)
                }else{
                    self.showError()
                }
            }else{
                self.showError()
            }
        }
    }
    
    func showError(){
        dispatch_async(dispatch_get_main_queue()){ [unowned self] in
            let ac = UIAlertController(title: "Loading error", message: "It was a problem to loading,", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    func parseJSON(json : NSArray){
        for result in json as NSArray{
            var id = result.objectForKey("id") as! String
            println("id:\(id)\n")
            var name = result.objectForKey("name") as! String
            println("name:\(name)\n")
            //            var sortable_name = result.objectForKey("sortable_name") as! String
            //            var slug = result.objectForKey("slug") as! String
            //            var place_type = result.objectForKey("place_type") as! String
            var location = result.objectForKey("location") as! NSDictionary
            let latitudeData : AnyObject? = location["Lat"]
            let longitudeData: AnyObject? = location["Lng"]
            
            println("latitude --> \(latitudeData)")
            println("longitude --> \(longitudeData)")
            //
            var address = result.objectForKey("address") as! String
            println("address:\(address)\n")
            //var city = result.objectForKey("city") as! String
            //println("city:\(city)\n")
            //            var destination = result.objectForKey("destination") as! String
            //            var destination_name = result.objectForKey("destination_name") as! String
            //            var tags = result.objectForKey("tags") as! String
            //            var cuisines = result.objectForKey("cuisines") as! String
            //            var cms_id = result.objectForKey("cms_id") as! String
            //            var google_id = result.objectForKey("google_id") as! String
            //            var photo_count = result.objectForKey("photo_count") as! String
            //            var rank = result.objectForKey("rank") as! NSInteger
            //            println("rank:\(rank)\n")
            
            
            
            var lat:String = latitudeData!.description
            var lon:String = longitudeData!.description
            
            let dict = ["name" : name , "address" : address, "latitudeData" :  lat, "longitudeData" : lon]
            
            objects.append(dict)
            
        }
        
        dispatch_async(dispatch_get_main_queue()){ [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = objects[indexPath.row]
                (segue.destinationViewController as! DetailViewController).detailItem = object
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let object = objects[indexPath.row]
        cell.textLabel!.text = object["name"]
        cell.detailTextLabel!.text = object["address"]
        
        return cell
    }
    
  

    
}
