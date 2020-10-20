import UIKit

enum gender {
    case male
    case female
}

struct User {
    let email: String
    let password: String
    let userName: String
    let nickName: String
    let gender: gender
    let organization: String
    let birth: Date
    var myCircle: [Circle]?
    var followCircle: [Circle]?
    let join: Date
    let profilePhoto: URL?
}
