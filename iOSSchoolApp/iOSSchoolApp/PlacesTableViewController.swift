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
        navigationController?.navigationBar.topItem?.title = "Places"
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
            let place = Place(newname: name, newlat: values[0], newlong: values[1], newtype: values[2])
            placesArray.append(place)
        }
        placesArray.sortInPlace({ $0.name < $1.name })
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
        
        var image = UIImage(named: "default")
        
        if place.name == "Wardenburg Health Services" {
            image = UIImage(named: "wardenburg")
        } else if place.name == "University Theatre" {
            image = UIImage(named: "universitytheatre")
        } else if place.name == "University Memorial Center (UMC)" {
            image = UIImage(named: "umc")
        } else if place.name == "Student Recreation Center" {
            image = UIImage(named: "rec")
        } else if place.name == "Sewall Hall" {
            image = UIImage(named: "sewall")
        } else if place.name == "CU Heritage Center (Old Main)" {
            image = UIImage(named: "oldmain")
        } else if place.name == "Ramaley Biology" {
            image = UIImage(named: "bio")
        } else if place.name == "Norlin Library" {
            image = UIImage(named: "norlin")
        } else if place.name == "Imig Music Building" {
            image = UIImage(named: "music")
        } else if place.name == "Macky Auditorium" {
            image = UIImage(named: "macky")
        } else if place.name == "McKenna Languages" {
            image = UIImage(named: "mckenna")
        } else if place.name == "Ketchum Arts and Sciences" {
            image = UIImage(named: "ketchum")
        } else if place.name == "Museum of Natural History" {
            image = UIImage(named: "historymuseum")
        } else if place.name == "Hale Science" {
            image = UIImage(named: "hale")
        } else if place.name == "Hellems Arts and Sciences" {
            image = UIImage(named: "hellems")
        } else if place.name == "Environmental Design" {
            image = UIImage(named: "envdesign")
        } else if place.name == "Guggenheim Geography" {
            image = UIImage(named: "gugg")
        } else if place.name == "Ekeley Sciences" {
            image = UIImage(named: "ekeley")
        } else if place.name == "School of Education" {
            image = UIImage(named: "education")
        } else if place.name == "Eaton Humanities" {
            image = UIImage(named: "eaton")
        } else if place.name == "Economics Department" {
            image = UIImage(named: "econ")
        } else if place.name == "Cristol Chemistry and Biochemistry" {
            image = UIImage(named: "cristol")
        } else if place.name == "Clare" {
            image = UIImage(named: "clare")
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
            //var placeName = placesArray[indexPath.row].name
            //var tempPlace = Place(
            detailVC.title = placesArray[indexPath.row].name
            detailVC.placesDetail = placesArray
            detailVC.selectedPlace = indexPath.row
            //detailVC.place = placesDict[placeName]
        } else if segue.identifier == "moodle" {
            let vc = segue.destinationViewController as UIViewController
            vc.navigationItem.title = "Moodle"
            navigationItem.title = "Home"
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
