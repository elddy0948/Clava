//
//  Circle.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/18.
//

import Foundation

//- name (String)
//- organization (String)
//- description (String)
//- circleProfilePhoto (URL)
//- follower ([User])
//- circleMember ([CircleMember])
//- category (String)
//- post ([Post])


struct Circle {
    let name : String
    let organization: String
    let description: String
    let circleProfilePhoto: String
    let follower: [User]
    let circleMember: [CircleMember]
    let category: String
    let post: [Post]
}
