//
//  CircleMember.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/18.
//


//- member (User)
//- position (String)

import Foundation
import SwiftyJSON

class CircleMember : NSObject, NSCoding{

    var email : String!
    var id : Int!
    var joinDate : String!
    var level : Int!
    var name : String!
    var nickname : String!
    var password : String!
    var profilePhoto : String!
    var userGender : String!
    var userOrganization : String!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        email = json["email"].stringValue
        id = json["id"].intValue
        joinDate = json["join_Date"].stringValue
        level = json["level"].intValue
        name = json["name"].stringValue
        nickname = json["nickname"].stringValue
        password = json["password"].stringValue
        profilePhoto = json["profilePhoto"].stringValue
        userGender = json["user_gender"].stringValue
        userOrganization = json["user_organization"].stringValue
    }

    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if email != nil{
            dictionary["email"] = email
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


    @objc required init(coder aDecoder: NSCoder)
    {
        email = aDecoder.decodeObject(forKey: "email") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        joinDate = aDecoder.decodeObject(forKey: "join_Date") as? String
        level = aDecoder.decodeObject(forKey: "level") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
        password = aDecoder.decodeObject(forKey: "password") as? String
        profilePhoto = aDecoder.decodeObject(forKey: "profilePhoto") as? String
        userGender = aDecoder.decodeObject(forKey: "user_gender") as? String
        userOrganization = aDecoder.decodeObject(forKey: "user_organization") as? String
    }


    func encode(with aCoder: NSCoder)
    {
        if email != nil{
            aCoder.encode(email, forKey: "email")
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

