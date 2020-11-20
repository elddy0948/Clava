//
//  File.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/18.
//

//- author (User)
//- description (String)
//- created (Date)

import Foundation
import SwiftyJSON


class Comment : NSObject, NSCoding{

    var author : String!
    var descriptionField : String!
    var id : Int!
    var postId : Int!
    var writeDate : String!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        author = json["author"].stringValue
        descriptionField = json["description"].stringValue
        id = json["id"].intValue
        postId = json["postId"].intValue
        writeDate = json["write_Date"].stringValue
    }

    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if author != nil{
            dictionary["author"] = author
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if postId != nil{
            dictionary["postId"] = postId
        }
        if writeDate != nil{
            dictionary["write_Date"] = writeDate
        }
        return dictionary
    }

    @objc required init(coder aDecoder: NSCoder)
    {
        author = aDecoder.decodeObject(forKey: "author") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        postId = aDecoder.decodeObject(forKey: "postId") as? Int
        writeDate = aDecoder.decodeObject(forKey: "write_Date") as? String
    }

    func encode(with aCoder: NSCoder)
    {
        if author != nil{
            aCoder.encode(author, forKey: "author")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if postId != nil{
            aCoder.encode(postId, forKey: "postId")
        }
        if writeDate != nil{
            aCoder.encode(writeDate, forKey: "write_Date")
        }

    }

}

