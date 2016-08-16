//
//  PlacesTableViewController.swift
//  iOSSchoolApp
//
//  Created by Jessie Albarian on 7/28/16.
//  Copyright © 2016 LittleBirdStudios. All rights reserved.
//

import UIKit
import Firebase



class PlacesTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, UIPopoverPresentationControllerDelegate {
    
    // Object variables
    var placesDict = [String : Place]() // Used as master store for all of the objects
    var placesArray = [String]() // Used as a master container for all of the place names
    var imagesArray : [AnyObject] = []
    

    // Firebase Variables
    var ref = FIRDatabase.database().reference()
    let placesSnapshot = FIRDataSnapshot()
    var temp : FIRDataSnapshot!
    let storage = FIRStorage.storage()
    
    
    // Search variables
    var filteredNames = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    
    // Spinny Thingy
    let indicator:UIActivityIndicatorView = UIActivityIndicatorView  (activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    

    
    //-----------------------
    // Resize image to circle
    //-----------------------
    func resizeImage(image:UIImage, toTheSize size:CGSize)->UIImage{
        let scale = CGFloat(max(size.width/image.size.width, size.height/image.size.height))
        let width:CGFloat  = image.size.width * scale
        let height:CGFloat = image.size.height * scale
        
        let rr:CGRect = CGRectMake( 0, 0, width, height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.drawInRect(rr)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    

    
//    //-------------------
//    // Configure Database
//    //-------------------
    func configureDatabase(){
        ref.child("places").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            self.temp = snapshot
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    
    //-----------
    // Get Images
    //-----------
    func getImages(){
        
        let storageRef = storage.referenceForURL("gs://cuapp-5d360.appspot.com")
        var defaultimage : UIImage?
        
        // Get Default Pic
        let defaultPic = storageRef.child("places/default.png")
        defaultPic.dataWithMaxSize(1 * 1000 * 1000) { (data, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                defaultimage = UIImage(data: data!)!
            }
        }
        
        // Get all images
        for each in self.placesArray {
            let placeObject = self.placesDict[each]
            
            if placeObject?.imageName == "default" {
                self.placesDict[each]?.image = defaultimage
            } else {
                let pic = storageRef.child("places/" + (placeObject?.imageName)! + ".png")
                pic.dataWithMaxSize(1 * 300 * 300) { (data, error) -> Void in
                    if (error != nil) {
                        // an error occurred
                    } else {
                        let image = UIImage(data: data!)!
                        self.placesDict[each]?.image = image
                    }
                }
            }
        }
        tableView.reloadData()
        
        self.indicator.stopAnimating()
        self.indicator.hidesWhenStopped = true
    }
    
    
    
    //----------------
    // View Did Appear
    //----------------
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var tempDict = [String:AnyObject]()
        
        
        // Parse through data
        if placesArray.isEmpty == true {
            tempDict = temp.value as! [String:AnyObject]
            
            for (name, valueObject) in tempDict {
                var values = valueObject as! [String]
                
                if(values.count == 4){
                    placesDict[name] = Place(newimage: values[0], newname: name, newlat: values[1], newlong: values[2], newtype: values[3])
                }
                else if(values.count == 5){ //Needed in case the place has a picture name associated with it
                    placesDict[name] = Place(newimage: values[0], newname: name, newlat: values[1], newlong: values[2], newtype: values[3], newBuildingCode: values[4])
                }
                
                placesArray.append(name)
            }
            
            placesArray.sortInPlace()
            filteredNames = placesArray
            
        }
        getImages()
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), { () -> Void in
//            self.getImages()
////            self.tableView.reloadData()
//        })
//        tableView.reloadData()
    }

    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureDatabase()
    }
    
    
    
    //-------------
    // viewDidLoad
    //-------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.color = UIColor .grayColor()
        indicator.frame = CGRectMake(0.0, 0.0, 100.0, 100.0)
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.bringSubviewToFront(self.view)
        indicator.startAnimating()
        
        
    
        
        
        
        //-----------
        // Search bar
        //-----------
        searchController.searchBar.scopeButtonTitles = ["All", "Housing", "Building", "Dining"]
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.becomeFirstResponder()
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        
        
        //--------
        // Navbar
        //--------
        navigationController?.navigationBar.topItem?.title = "Places"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        
        // Get Images
        var image : UIImage
        if placeObject!.image != nil {
            image = placeObject!.image!
        } else {
            image = UIImage(named: "default")!
        }
        
        cell.textLabel?.text = place
        navigationController?.navigationBar.topItem?.title = "Places"
        
        cell.detailTextLabel?.text = placeObject?.buildingCode
        
        let newImage = resizeImage(image, toTheSize: CGSizeMake(90, 90))
//        let cellImageLayer: CALayer?  = cell.imageView!.layer
//        cellImageLayer!.cornerRadius = cellImageLayer!.frame.size.width / 2
//        cellImageLayer!.masksToBounds = true
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
            
//            detailVC.popoverPresentationController!.delegate = self
//            detailVC.preferredContentSize = CGSize(width: 320, height: 186)
            
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
