//
//  PlacesTableViewController.swift
//  iOSSchoolApp
//
//  Created by Jessie Albarian on 7/28/16.
//  Copyright © 2016 LittleBirdStudios. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    // Object variables
    var placesDict = [String : Place]() // Used as master store for all of the objects
    var placesArray = [String]() // Used as a master container for all of the place names
    var tempDict = [String : [String]]() // Needed as a helper to create the places dictionary
    
    // Search variables
    var filteredNames = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    
    func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{
        
        
        let scale = CGFloat(max(size.width/image.size.width,
            size.height/image.size.height))
        let width:CGFloat  = image.size.width * scale
        let height:CGFloat = image.size.height * scale;
        
        let rr:CGRect = CGRectMake( 0, 0, width, height);
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        image.drawInRect(rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return newImage
    }
    
    //-------------
    // viewDidLoad
    //-------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.scopeButtonTitles = ["All", "Housing", "Building", "Dining"]
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        //--------
        // Navbar
        //--------
        navigationController?.navigationBar.topItem?.title = "Place"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
//        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
//        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        //------------
        // Search bar
        //------------
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        
        //------------------
        // Load places plist
        //------------------
        let path = NSBundle.mainBundle().pathForResource("places", ofType: "plist")
        tempDict = NSDictionary(contentsOfFile: path!) as! [String: [String]]
        for (name, values) in tempDict {
            if(values.count == 3){
                placesDict[name] = Place(newname: name, newlat: values[0], newlong: values[1], newtype: values[2])
            }
            else if(values.count == 4){ //Needed in case the place has a picture name associated with it
                placesDict[name] = Place(newname: name, newlat: values[0], newlong: values[1], newtype: values[2], newPictureName: values[3])
            }
            placesArray.append(name)
        }
        placesArray.sortInPlace()
        filteredNames = placesArray
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredNames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cellidentifier", forIndexPath: indexPath)

        let place = filteredNames[indexPath.row]
        let placeObject = placesDict[place]
        
        
        cell.textLabel?.text = place
        navigationController?.navigationBar.topItem?.title = place
        cell.detailTextLabel?.text = placeObject!.placeType
        
        var image = UIImage(named: "default")
        
        if(placeObject!.pictureName != ""){
            image = UIImage(named: placeObject!.pictureName)
        }


        let newImage = resizeImage(image!, toTheSize: CGSizeMake(85, 85))
        let cellImageLayer: CALayer?  = cell.imageView!.layer
//        cellImageLayer!.cornerRadius = cellImageLayer!.frame.size.width / 2
        cellImageLayer!.masksToBounds = true
        cell.imageView!.image = newImage
        return cell
    }
 

    
    
    //------------------
    // Prepare for Segue
    //------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender:
        AnyObject?) {
        if segue.identifier == "placessegue" {
            let detailVC = segue.destinationViewController as! MapViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!

            //sets the data for the destination controller
            detailVC.title = filteredNames[indexPath.row]
            detailVC.place = placesDict[filteredNames[indexPath.row]]!
        } else if segue.identifier == "moodle" {
            let vc = segue.destinationViewController as UIViewController
            vc.navigationItem.title = "Moodle"
            navigationItem.title = "Home"
        }
    }
    

    func filterContentForSearchText(searchText: String, scope: String) {
        filteredNames = placesArray.filter { place in
            let categoryMatch = (scope == "All") || (placesDict[place]!.placeType == scope)
            return  categoryMatch && (searchText == "" || place.lowercaseString.containsString(searchText.lowercaseString))
        }
        
        tableView.reloadData()
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
