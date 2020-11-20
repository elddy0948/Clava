//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/
//  Created on November 20, 2020

import Foundation
import SwiftyJSON


class Circle : NSObject, NSCoding{
    
    var category : String!
    var circleFollower : [User]!
    var circleMember : [CircleMember]!
    var circlePosts : [Post]!
    var circleProfilePhoto : String!
    var descriptionField : String!
    var id : Int!
    var leader : String!
    var name : String!
    var organization : String!
    var place : String!
    
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        category = json["category"].stringValue
        circleFollower = [User]()
        let circleFollowerArray = json["circleFollower"].arrayValue
        for circleFollowerJson in circleFollowerArray{
            circleFollower.append(User(fromJson: circleFollowerJson))
        }
        circleMember = [CircleMember]()
        let circleMemberArray = json["circleMember"].arrayValue
        for circleMemberJson in circleMemberArray{
            let value = CircleMember(fromJson: circleMemberJson)
            circleMember.append(value)
        }
        circlePosts = [Post]()
        let circlePostsArray = json["circlePosts"].arrayValue
        for circlePostsJson in circlePostsArray{
            let value = Post(fromJson: circlePostsJson)
            circlePosts.append(value)
        }
        circleProfilePhoto = json["circleProfilePhoto"].stringValue
        descriptionField = json["description"].stringValue
        id = json["id"].intValue
        leader = json["leader"].stringValue
        name = json["name"].stringValue
        organization = json["organization"].stringValue
        place = json["place"].stringValue
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if category != nil{
            dictionary["category"] = category
        }
        if circleFollower != nil{
            dictionary["circleFollower"] = circleFollower
        }
        if circleMember != nil{
            var dictionaryElements = [[String:Any]]()
            for circleMemberElement in circleMember {
                dictionaryElements.append(circleMemberElement.toDictionary())
            }
            dictionary["circleMember"] = dictionaryElements
            
            
        }
        if circlePosts != nil{
            var dictionaryElements = [[String:Any]]()
            for circlePostsElement in circlePosts {
                dictionaryElements.append(circlePostsElement.toDictionary())
            }
            dictionary["circlePosts"] = dictionaryElements
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
        if leader != nil{
            dictionary["leader"] = leader
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
        circleFollower = aDecoder.decodeObject(forKey: "circleFollower") as? [User]
        circleMember = aDecoder.decodeObject(forKey: "circleMember") as? [CircleMember]
        circlePosts = aDecoder.decodeObject(forKey: "circlePosts") as? [Post]
        circleProfilePhoto = aDecoder.decodeObject(forKey: "circleProfilePhoto") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        leader = aDecoder.decodeObject(forKey: "leader") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        organization = aDecoder.decodeObject(forKey: "organization") as? String
        place = aDecoder.decodeObject(forKey: "place") as? String
    }
    
    func encode(with aCoder: NSCoder)
    {
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if circleFollower != nil{
            aCoder.encode(circleFollower, forKey: "circleFollower")
        }
        if circleMember != nil{
            aCoder.encode(circleMember, forKey: "circleMember")
        }
        if circlePosts != nil{
            aCoder.encode(circlePosts, forKey: "circlePosts")
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
        if leader != nil{
            aCoder.encode(leader, forKey: "leader")
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
