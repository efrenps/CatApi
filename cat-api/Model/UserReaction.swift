//
//  CategoryReaction.swift
//  cat-api
//
//  Created by Carlos Perez on 3/8/22.
//

import Foundation

struct UserReaction {
    var name: String!
    var date: Date!
    var liked: Bool!
    
    init(name: String, date: Date, liked: Bool){
        self.name = name
        self.date = date
        self.liked = liked
    }
}
