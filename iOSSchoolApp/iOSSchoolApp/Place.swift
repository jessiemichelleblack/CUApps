//
//  Place.swift
//  iOSSchoolApp
//
//  Created by Jessie Albarian on 8/3/16.
//  Copyright © 2016 LittleBirdStudios. All rights reserved.
//

import Foundation

class Place {
    var name : String
    var latCoordinate : String
    var longCoordinate : String
    var placeType : String
    
    init (newname : String, newlat : String, newlong : String, newtype : String){
        self.name = newname
        self.latCoordinate = newlat
        self.longCoordinate = newlong
        self.placeType = newtype
    }
}