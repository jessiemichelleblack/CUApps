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
    var placesDict = [String : [String]]()
    var placesArray = [Place]()
    var tempDict = [String : [String]]()
    
    // Search variables
    var filteredNames = [Place]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
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
        navigationController?.navigationBar.topItem?.title = "Places"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        
        
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
            let place = Place(newname: name, newlat: values[0], newlong: values[1], newtype: values[2])
            placesArray.append(place)
        }
        placesArray.sortInPlace({ $0.name < $1.name })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
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
        if searchController.active && searchController.searchBar.text != "" {
            return filteredNames.count
        }
        return placesArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cellidentifier", forIndexPath: indexPath)

        let place: Place
        if searchController.active && searchController.searchBar.text != "" {
            place = filteredNames[indexPath.row]
        } else {
            place = placesArray[indexPath.row]
        }
        cell.textLabel?.text = place.name
        cell.detailTextLabel?.text = place.placeType
        
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
            detailVC.title = placesArray[indexPath.row].name
            detailVC.placesDetail = placesArray
            detailVC.selectedPlace = indexPath.row
        }
    }
    
    
    
    
    
//    func filterContentForSearchText(searchText: String, scope: String = "All") {
//        filteredNames = placesArray.filter { name in
//            return name.name.lowercaseString.containsString(searchText.lowercaseString)
//        }
//        
//        tableView.reloadData()
//    }
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredNames = placesArray.filter { place in
            let categoryMatch = (scope == "All") || (place.placeType == scope)
            return  categoryMatch && place.name.lowercaseString.containsString(searchText.lowercaseString)
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
