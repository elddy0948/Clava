//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on November 15, 2020

import Foundation
import SwiftyJSON


class Circle : NSObject, NSCoding{

    var category : String!
    var circleProfilePhoto : String!
    var descriptionField : String!
    var id : Int!
    var name : String!
    var organization : String!
    var place : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        category = json["category"].stringValue
        circleProfilePhoto = json["circleProfilePhoto"].stringValue
        descriptionField = json["description"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
        organization = json["organization"].stringValue
        place = json["place"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if category != nil{
            dictionary["category"] = category
        }
        if circleProfilePhoto != nil{
            dictionary["circleProfilePhoto"] = circleProfilePhoto
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if organization != nil{
            dictionary["organization"] = organization
        }
        if place != nil{
            dictionary["place"] = place
        }
        return dictionary
    }


    @objc required init(coder aDecoder: NSCoder)
    {
        category = aDecoder.decodeObject(forKey: "category") as? String
        circleProfilePhoto = aDecoder.decodeObject(forKey: "circleProfilePhoto") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        organization = aDecoder.decodeObject(forKey: "organization") as? String
        place = aDecoder.decodeObject(forKey: "place") as? String
    }

    func encode(with aCoder: NSCoder)
    {
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if circleProfilePhoto != nil{
            aCoder.encode(circleProfilePhoto, forKey: "circleProfilePhoto")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if organization != nil{
            aCoder.encode(organization, forKey: "organization")
        }
        if place != nil{
            aCoder.encode(place, forKey: "place")
        }

    }

}
