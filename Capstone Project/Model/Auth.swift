import Foundation
import SwiftyJSON


class Auth : NSObject, NSCoding{

    var accessToken : String!
    var userNickname : String!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        accessToken = json["accessToken"].stringValue
        userNickname = json["userNickname"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accessToken != nil{
            dictionary["accessToken"] = accessToken
        }
        if userNickname != nil{
            dictionary["userNickname"] = userNickname
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
        userNickname = aDecoder.decodeObject(forKey: "userNickname") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if accessToken != nil{
            aCoder.encode(accessToken, forKey: "accessToken")
        }
        if userNickname != nil{
            aCoder.encode(userNickname, forKey: "userNickname")
        }

    }

}
