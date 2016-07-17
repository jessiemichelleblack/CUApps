//
//  CollectionViewController.swift
//  iOSCampusApp
//
//  Created by Jessie Albarian on 7/16/16.
//  Copyright © 2016 LittleBirdStudios. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    
    
    
    //----------
    // Variables
    //----------
    var iconImages = [String]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iconImages.append("icon1")
        
        
        //--------------------------
        // Set navigation properties
        //--------------------------
        navigationController!.navigationBar.barTintColor = UIColor(red:51/255, green:102/255, blue:153/255, alpha:1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        

        
        
        //----------------------
        // Get date to set title
        //----------------------
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([ .Hour, .Minute, .Second], fromDate: date)
        let hour = components.hour
        
        switch hour {
        case 1 ... 11:
            navigationController!.navigationBar.topItem!.title = "Good Morning"
        case 12 ... 16:
            navigationController!.navigationBar.topItem!.title = "Good Afternoon"
        case 17 ... 24:
            navigationController!.navigationBar.topItem!.title = "Good Evening"
        default:
            navigationController!.navigationBar.topItem!.title = "Hello!"
        }
    }
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
 

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconImages.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
    
        // Configure the cell
        let image = UIImage(named: iconImages[indexPath.row])
        cell.iconImage.image = image
        if iconImages[indexPath.row] == "icon1"{
            cell.iconText.text = "Maps"
            cell.iconText.textColor = UIColor.whiteColor()
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
