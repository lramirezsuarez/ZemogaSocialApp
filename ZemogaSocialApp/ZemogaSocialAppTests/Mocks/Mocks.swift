//
//  Mocks.swift
//  ZemogaSocialAppTests
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import Foundation
@testable import ZemogaSocialApp

struct Mocks {
    static let posts = [Post(id: 1, userID: 1, title: "Title 1", body: "Body 1", isFavorite: false, read: false),
                        Post(id: 2, userID: 2, title: "Title 2", body: "Body 2", isFavorite: false, read: false),
                        Post(id: 3, userID: 3, title: "Title 3", body: "Body 3", isFavorite: true, read: true)]
    
    static let comments = [Comment(id: 1, postId: 1, name: "Comment 1", email: "l@l.c", body: "Body comment 1"),
                           Comment(id: 2, postId: 1, name: "Comment 2", email: "l@l.c", body: "Body comment 2")]
    
    static let users = [User(id: 1, name: "Luis", username: "lramirezsuarez", email: "l@l.c", phone: "1234567890")]
}
