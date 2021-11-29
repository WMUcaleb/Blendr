//
//  Restaurant.swift
//  Blendr
//
//  Created by Selyn Ung on 11/22/21.
//

import Foundation
import UIKit

class Restaurant {
    
    // ––––– Establish Properties –––––
    var imageURL: URL?
    var url: URL?
    var name: String
    var mainCategory: String
    var phone: String
    var reviews: Int
    var address1: String
    var city: String
    var zip_code: String
    var state: String
    var address: String
    var latitude: Double
    var longitude: Double
    

    // ––––– Complete initializer for Restaurant
    init(dict: [String: Any]) {
        imageURL = URL(string: dict["image_url"] as! String)
        name = dict["name"] as! String
//        rating = dict["rating"] as! Double
        reviews = dict["review_count"] as! Int
        phone = dict["display_phone"] as! String
        url = URL(string: dict["url"] as! String)
        mainCategory = Restaurant.getMainCategory(dict: dict)
        address1 = Restaurant.getAddress1(dict: dict)
        city = Restaurant.getCity(dict: dict)
        zip_code = Restaurant.getZip(dict: dict)
        state = Restaurant.getState(dict: dict)
        address = address1 + ", " + city + ", " + state + " " + zip_code
        latitude = Restaurant.getLatitude(dict: dict) as! Double
        longitude = Restaurant.getLongitude(dict: dict) as! Double
    }
    
    // Helper function to get First category from restaurant
    static func getMainCategory(dict: [String:Any]) -> String {
        let categories = dict["categories"] as! [[String: Any]]
        return categories[0]["title"] as! String
    }
    
    // Helper function to get coordinates
    static func getLatitude(dict: [String: Any]) -> NSNumber {
        let coordinates = dict["coordinates"] as! [String: Any]
        return coordinates["latitude"] as! NSNumber
    }
    
    static func getLongitude(dict: [String: Any]) -> NSNumber {
        let coordinates = dict["coordinates"] as! [String: Any]
        return coordinates["longitude"] as! NSNumber
    }
    
    // Helper function to get location fields
    static func getAddress1(dict: [String: Any]) -> String {
        let location = dict["location"] as! [String: Any]
        return location["address1"] as! String
    }
    
    static func getCity(dict: [String: Any]) -> String {
        let location = dict["location"] as! [String: Any]
        return location["city"] as! String
    }
    
    static func getZip(dict: [String: Any]) -> String {
        let location = dict["location"] as! [String: Any]
        return location["zip_code"] as! String
    }
    
    static func getState(dict: [String: Any]) -> String {
        let location = dict["location"] as! [String: Any]
        return location["state"] as! String
    }

    
}
