//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on November 16, 2020

import Foundation
import SwiftyJSON


class User : NSObject, NSCoding{

    var active : Bool!
    var admin : Bool!
    var email : String!
    var followCircle : [Circle]!
    var id : Int!
    var joinDate : String!
    var level : Int!
    var myCircle : [Circle]!
    var name : String!
    var nickname : String!
    var password : String!
    var profilePhoto : String!
    var userGender : String!
    var userOrganization : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        active = json["active"].boolValue
        admin = json["admin"].boolValue
        email = json["email"].stringValue
        followCircle = [Circle]()
        let followCircleArray = json["followCircle"].arrayValue
        for followCircleJson in followCircleArray{
            let value = Circle(fromJson: followCircleJson)
            followCircle.append(value)
        }
        id = json["id"].intValue
        joinDate = json["join_Date"].stringValue
        level = json["level"].intValue
        myCircle = [Circle]()
        let myCircleArray = json["myCircle"].arrayValue
        for myCircleJson in myCircleArray{
            let value = Circle(fromJson: myCircleJson)
            myCircle.append(value)
        }
        name = json["name"].stringValue
        nickname = json["nickname"].stringValue
        password = json["password"].stringValue
        profilePhoto = json["profilePhoto"].stringValue
        userGender = json["user_gender"].stringValue
        userOrganization = json["user_organization"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if active != nil{
            dictionary["active"] = active
        }
        if admin != nil{
            dictionary["admin"] = admin
        }
        if email != nil{
            dictionary["email"] = email
        }
        if followCircle != nil{
        var dictionaryElements = [[String:Any]]()
        for followCircleElement in followCircle {
            dictionaryElements.append(followCircleElement.toDictionary())
        }
        dictionary["followCircle"] = dictionaryElements
        }
        if id != nil{
            dictionary["id"] = id
        }
        if joinDate != nil{
            dictionary["join_Date"] = joinDate
        }
        if level != nil{
            dictionary["level"] = level
        }
        if myCircle != nil{
            dictionary["myCircle"] = myCircle
        }
        if name != nil{
            dictionary["name"] = name
        }
        if nickname != nil{
            dictionary["nickname"] = nickname
        }
        if password != nil{
            dictionary["password"] = password
        }
        if profilePhoto != nil{
            dictionary["profilePhoto"] = profilePhoto
        }
        if userGender != nil{
            dictionary["user_gender"] = userGender
        }
        if userOrganization != nil{
            dictionary["user_organization"] = userOrganization
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        active = aDecoder.decodeObject(forKey: "active") as? Bool
        admin = aDecoder.decodeObject(forKey: "admin") as? Bool
        email = aDecoder.decodeObject(forKey: "email") as? String
        followCircle = aDecoder.decodeObject(forKey: "followCircle") as? [Circle]
        id = aDecoder.decodeObject(forKey: "id") as? Int
        joinDate = aDecoder.decodeObject(forKey: "join_Date") as? String
        level = aDecoder.decodeObject(forKey: "level") as? Int
        myCircle = aDecoder.decodeObject(forKey: "myCircle") as? [Circle]
        name = aDecoder.decodeObject(forKey: "name") as? String
        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        password = aDecoder.decodeObject(forKey: "password") as? String
        profilePhoto = aDecoder.decodeObject(forKey: "profilePhoto") as? String
        userGender = aDecoder.decodeObject(forKey: "user_gender") as? String
        userOrganization = aDecoder.decodeObject(forKey: "user_organization") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if active != nil{
            aCoder.encode(active, forKey: "active")
        }
        if admin != nil{
            aCoder.encode(admin, forKey: "admin")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if followCircle != nil{
            aCoder.encode(followCircle, forKey: "followCircle")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if joinDate != nil{
            aCoder.encode(joinDate, forKey: "join_Date")
        }
        if level != nil{
            aCoder.encode(level, forKey: "level")
        }
        if myCircle != nil{
            aCoder.encode(myCircle, forKey: "myCircle")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if nickname != nil{
            aCoder.encode(nickname, forKey: "nickname")
        }
        if password != nil{
            aCoder.encode(password, forKey: "password")
        }
        if profilePhoto != nil{
            aCoder.encode(profilePhoto, forKey: "profilePhoto")
        }
        if userGender != nil{
            aCoder.encode(userGender, forKey: "user_gender")
        }
        if userOrganization != nil{
            aCoder.encode(userOrganization, forKey: "user_organization")
        }

    }

}
