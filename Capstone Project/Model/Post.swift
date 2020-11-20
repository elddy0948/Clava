//
//  UserPost.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/16.
//

//- author (CircleMember)
//- description (String)
//- postPhoto (URL)
//- created (Date)
//- likeCount (Int)
//- comment (Comment)

import Foundation
import SwiftyJSON


class Post : NSObject, NSCoding{

    var author : String!
    var circleId : Int!
    var descriptionField : String!
    var id : Int!
    var likeNum : Int!
    var postComment : [Comment]!
    var postPhoto : [Photo]!
    var writeDate : String!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        author = json["author"].stringValue
        circleId = json["circleId"].intValue
        descriptionField = json["description"].stringValue
        id = json["id"].intValue
        likeNum = json["likeNum"].intValue
        postComment = [Comment]()
        let postCommentArray = json["postComment"].arrayValue
        for postCommentJson in postCommentArray{
            postComment.append(Comment(fromJson: postCommentJson))
        }
        postPhoto = [Photo]()
        let postPhotoArray = json["postPhoto"].arrayValue
        for postPhotoJson in postPhotoArray{
            postPhoto.append(Photo(fromJson: postPhotoJson))
        }
        writeDate = json["write_Date"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if author != nil{
            dictionary["author"] = author
        }
        if circleId != nil{
            dictionary["circleId"] = circleId
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if likeNum != nil{
            dictionary["likeNum"] = likeNum
        }
        if postComment != nil{
            dictionary["postComment"] = postComment
        }
        if postPhoto != nil{
            dictionary["postPhoto"] = postPhoto
        }
        if writeDate != nil{
            dictionary["write_Date"] = writeDate
        }
        return dictionary
    }

    @objc required init(coder aDecoder: NSCoder)
    {
        author = aDecoder.decodeObject(forKey: "author") as? String
        circleId = aDecoder.decodeObject(forKey: "circleId") as? Int
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        likeNum = aDecoder.decodeObject(forKey: "likeNum") as? Int
        postComment = aDecoder.decodeObject(forKey: "postComment") as? [Comment]
        postPhoto = aDecoder.decodeObject(forKey: "postPhoto") as? [Photo]
        writeDate = aDecoder.decodeObject(forKey: "write_Date") as? String
    }

    func encode(with aCoder: NSCoder)
    {
        if author != nil{
            aCoder.encode(author, forKey: "author")
        }
        if circleId != nil{
            aCoder.encode(circleId, forKey: "circleId")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if likeNum != nil{
            aCoder.encode(likeNum, forKey: "likeNum")
        }
        if postComment != nil{
            aCoder.encode(postComment, forKey: "postComment")
        }
        if postPhoto != nil{
            aCoder.encode(postPhoto, forKey: "postPhoto")
        }
        if writeDate != nil{
            aCoder.encode(writeDate, forKey: "write_Date")
        }
    }
}
