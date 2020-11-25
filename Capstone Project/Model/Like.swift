import Foundation
import SwiftyJSON


class Like : NSObject, NSCoding{

    var id : Int!
    var postId : Int!
    var userId : Int!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].intValue
        postId = json["postId"].intValue
        userId = json["userId"].intValue
    }

    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        if postId != nil{
            dictionary["postId"] = postId
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        return dictionary
    }


    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        postId = aDecoder.decodeObject(forKey: "postId") as? Int
        userId = aDecoder.decodeObject(forKey: "userId") as? Int
    }

    func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if postId != nil{
            aCoder.encode(postId, forKey: "postId")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
    }
}
