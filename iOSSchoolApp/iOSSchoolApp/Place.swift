//
//  Place.swift
//  iOSSchoolApp
//
//  Created by Jessie Albarian on 8/3/16.
//  Copyright © 2016 LittleBirdStudios. All rights reserved.
//

import Foundation
import UIKit

class Place {
    var imageName : String
    var name : String
    var latCoordinate : String
    var longCoordinate : String
    var placeType : String
    var buildingCode : String
    var image : UIImage?
    
    //Default constructor
    init (){
        self.imageName = ""
        self.name = ""
        self.latCoordinate = ""
        self.longCoordinate = ""
        self.placeType = ""
        self.buildingCode = ""
        
    }
    
    //Constructor for items without a building code
    init (newimage : String, newname : String, newlat : String, newlong : String, newtype : String){
        self.imageName = newimage
        self.name = newname
        self.latCoordinate = newlat
        self.longCoordinate = newlong
        self.placeType = newtype
        self.buildingCode = ""
        
    }
    
    //Constructor for items with building code
    init (newimage : String, newname : String, newlat : String, newlong : String, newtype : String, newBuildingCode : String){
        self.imageName = newimage
        self.name = newname
        self.latCoordinate = newlat
        self.longCoordinate = newlong
        self.placeType = newtype
        self.buildingCode = newBuildingCode
        
        
    }
}