//
//  Photo.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/11/20.
//

import Foundation
import SwiftyJSON


class Photo : NSObject, NSCoding{

    var id : Int!
    var photoUrl : String!
    var postId : Int!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].intValue
        photoUrl = json["photoUrl"].stringValue
        postId = json["postId"].intValue
    }

    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        if photoUrl != nil{
            dictionary["photoUrl"] = photoUrl
        }
        if postId != nil{
            dictionary["postId"] = postId
        }
        return dictionary
    }


    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        photoUrl = aDecoder.decodeObject(forKey: "photoUrl") as? String
        postId = aDecoder.decodeObject(forKey: "postId") as? Int
    }


    func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if photoUrl != nil{
            aCoder.encode(photoUrl, forKey: "photoUrl")
        }
        if postId != nil{
            aCoder.encode(postId, forKey: "postId")
        }

    }

}
