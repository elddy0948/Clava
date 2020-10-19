//
//  BetweenUserCircle.swift
//  Capstone Project
//
//  Created by 김호준 on 2020/10/20.
//

import Foundation

enum UserAndCircleType {
    case follow
    case belong
}

struct BetweenUserCircle {
    let type: UserAndCircleType
    let text: String
    let circle: Circle
}
