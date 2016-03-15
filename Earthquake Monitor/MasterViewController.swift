//
//  MasterViewController.swift
//  Earthquake Monitor
//
//  Created by JJLZ on 3/13/16.
//  Copyright © 2016 ESoft. All rights reserved.
//

import UIKit
import Alamofire

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var earthquakes = [Earthquake]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Clear title
        self.navigationItem.title = ""
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        
        // Load Earthquakes info
        loadEarthquakes()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let earthquake = earthquakes[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = earthquake
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return earthquakes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellSummary", forIndexPath: indexPath) as! TableViewCellSummary
        
        let earthquake = earthquakes[indexPath.row]
        cell.lblPlace.text = earthquake.place
        cell.lblMagnitude.text = "\(earthquake.mag!)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return false
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            earthquakes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            
        }
    }
    
    // MARK: Data
    
    func loadEarthquakes() {
        
        self.earthquakes.removeAll()
        
        Alamofire.request(GeoRouter.GetAllPastHour()) .responseJSON { response in
            
            // if the response was not successful
            guard response.result.isSuccess else {
                
                print("Error while downloading earthquakes info: \(response.result.error)")
                return
            }
            
            guard let responseJSON = response.result.value as? [String: AnyObject],
                let metadata = responseJSON["metadata"] as? [String: AnyObject],
                results = responseJSON["features"] as? [AnyObject]
                else {
                    
                    print("Invalid information received from the service")
                    return
            }
            
            //-- Get title --
            self.navigationItem.title = metadata["title"] as? String
            //--
            
            for item in results {
                
                if let properties = item["properties"] as? NSDictionary, let geometry = item["geometry"] as? NSDictionary {
                    
                    let earthquake = Earthquake()
                    
                    earthquake.place = properties["place"] as? String
                    earthquake.mag = properties["mag"] as? Float
                    
                    let point = geometry["coordinates"] as! NSArray
                    earthquake.longitude = point[0] as? Float
                    earthquake.latitude = point[1] as? Float
                    earthquake.depth = point[2] as? Float
                    
                    self.earthquakes.append(earthquake)
                }
            }
            
            // Reload table view
            NSOperationQueue.mainQueue().addOperationWithBlock({() -> Void in
            
                self.tableView.reloadData()
            })
        }
    }        
}

//"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

//"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"

//"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"
