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

struct Post {
    let author: CircleMember
    let description: String
    let postPhoto: URL
    let created: Date
    let likeCount: Int
    let comment: [Comment]
}
