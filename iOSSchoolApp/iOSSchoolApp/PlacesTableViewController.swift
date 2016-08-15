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
    
    
    // Firebase Variables
    var ref = FIRDatabase.database().reference()
    let placesSnapshot = FIRDataSnapshot()
    var temp : FIRDataSnapshot!
    let storage = FIRStorage.storage()
    
    
    // Search variables
    var filteredNames = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
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
    
    func getImages(){
        var imagesArray : [UIImage] = []
        
        let storageRef = storage.referenceForURL("gs://cuapp-5d360.appspot.com")

        // ADEN HALL
        let adenhall = storageRef.child("places/aden.png")
        adenhall.dataWithMaxSize(1 * 300 * 300) { (data, error) -> Void in
            if (error != nil) {
                // an error occurred
            } else {
                let adenImage : UIImage! = UIImage(data: data!)
                imagesArray.append(adenImage)
            }
        }
        
        // ANDREWS HALL
        let andrewshall = storageRef.child("places/andrews.png")
        andrewshall.dataWithMaxSize(1 * 300 * 300) { (data, error) -> Void in
            if (error != nil) {
                // an error occurred
            } else {
                let andrewImage : UIImage! = UIImage(data: data!)
                imagesArray.append(andrewImage)
            }
        }
        
        // ARNETT HALL
        let arnetthall = storageRef.child("places/arnett.png")
        arnetthall.dataWithMaxSize(1 * 300 * 300) { (data, error) -> Void in
            if (error != nil) {
                // an error occurred
            } else {
                let arnettImage : UIImage! = UIImage(data: data!)
                imagesArray.append(arnettImage)
            }
        }
        
        // ATLAS
        let atlas = storageRef.child("places/atlas.png")
        atlas.dataWithMaxSize(1 * 300 * 300) { (data, error) -> Void in
            if (error != nil) {
                // an error occurred
            } else {
                let atlasImage : UIImage! = UIImage(data: data!)
                imagesArray.append(atlasImage)
            }
        }
        
        // BAKER HALL
        let bakerhall = storageRef.child("places/baker.png")
        bakerhall.dataWithMaxSize(1 * 300 * 300) { (data, error) -> Void in
            if (error != nil) {
                // an error occurred
            } else {
                let bakerImage : UIImage! = UIImage(data: data!)
                imagesArray.append(bakerImage)
            }
        }
        
        // BALCH FIELDHOUSE
        let balch = storageRef.child("places/balch.png")
        balch.dataWithMaxSize(1 * 300 * 300) { (data, error) -> Void in
            if (error != nil) {
                // an error occurred
            } else {
                let balchImage : UIImage! = UIImage(data: data!)
                imagesArray.append(balchImage)
            }
        }
        
        // BEARCREEK APARTMENTS
        let bearcreek = storageRef.child("places/bearcreek.png")
        bearcreek.dataWithMaxSize(1 * 300 * 300) { (data, error) -> Void in
            if (error != nil) {
                // an error occurred
            } else {
                let bearcreekImage : UIImage! = UIImage(data: data!)
                imagesArray.append(bearcreekImage)
            }
        }
        
        // BENSON EARTH SCIENCES
        let benson = storageRef.child("places/benson.png")
        benson.dataWithMaxSize(1 * 300 * 300) { (data, error) -> Void in
            if (error != nil) {
                // an error occurred
            } else {
                let bensonImage : UIImage! = UIImage(data: data!)
                imagesArray.append(bensonImage)
            }
        }
        
        // BOOKSTORE
        let bookstore = storageRef.child("places/bookstore.png")
        bookstore.dataWithMaxSize(1 * 300 * 300) { (data, error) -> Void in
            if (error != nil) {
                // an error occurred
            } else {
                let bookstoreImage : UIImage! = UIImage(data: data!)
                imagesArray.append(bookstoreImage)
            }
        }
    }
    
    //-------------------
    // Configure Database
    //-------------------
    func configureDatabase(){
        ref.child("places").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            self.temp = snapshot
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    
    //----------------
    // View Did Appear
    //----------------
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // Parse through data
        var tempDict = [String:AnyObject]()
        tempDict = temp.value as! [String:AnyObject]
        for (name, valueObject) in tempDict {
            var values = valueObject as! [String]
            
            if(values.count == 3){
                placesDict[name] = Place(newname: name, newlat: values[0], newlong: values[1], newtype: values[2])
            }
            else if(values.count == 4){ //Needed in case the place has a picture name associated with it
                placesDict[name] = Place(newname: name, newlat: values[0], newlong: values[1], newtype: values[2], newBuildingCode: values[3])
            }
            
            placesArray.append(name)
        }
        placesArray.sortInPlace()
        filteredNames = placesArray
        // Reloads TableView
        self.tableView.reloadData()
    }
    
    //-------------
    // viewDidLoad
    //-------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDatabase()
        
        

        
        
        //-----------
        // Search bar
        //-----------
        searchController.searchBar.scopeButtonTitles = ["All", "Housing", "Building", "Dining"]
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        
        
        //--------
        // Navbar
        //--------
        navigationController?.navigationBar.topItem?.title = "Places"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        

//        print(ref.child("places"))
//        var tempDict = [String:AnyObject]()
//        var tempPlacesDict = [String : Place]()
//        var tempPlacesArray = [String]()
//        
//        ref.child("places").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
//
//                tempDict = snapshot.value as! [String:AnyObject]
//                for (name, valueObject) in tempDict {
////                    print(name)
////                    print(valueObject as! [AnyObject])
//                    var values = valueObject as! [AnyObject]
//                    if(values.count == 3){
//                        tempPlacesDict[name] = Place(newname: name, newlat: values[0] as! String, newlong: values[1] as! String, newtype: values[2] as! String)
//                    }
//                    else if(values.count == 4){ //Needed in case the place has a picture name associated with it
//                        tempPlacesDict[name] = Place(newname: name, newlat: values[0] as! String, newlong: values[1] as! String, newtype: values[2] as! String, newPictureName: values[3] as! String)
//                    }
// 
//                    tempPlacesArray.append(name)
//                }
//                tempPlacesArray.sortInPlace()
////            print(tempPlacesArray)
//                //filteredNames = placesArray
//            }) { (error) in
//                print(error.localizedDescription)
//                
//        }
//        print(tempPlacesArray)
//        placesDict=tempPlacesDict
//        placesArray = tempPlacesArray
//        filteredNames = placesArray
//        print(filteredNames)
        //print(ref.child("places").O
        //------------------
        // Load places plist
        //------------------
        /*
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
        */
        
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
    
        
        cell.textLabel?.text = place
        navigationController?.navigationBar.topItem?.title = "Places"
        
        cell.detailTextLabel?.text = placeObject?.buildingCode
        
        
        var image : UIImage

        image = UIImage(named: "default")!
        image = UIImage(named: placeObject!.name.lowercaseString)!


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
