//
//  MockDataRequest.swift
//  ZemogaSocialAppTests
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import Foundation
@testable import ZemogaSocialApp

struct MockDataRequest: DataRequestProtocol {
    static func getPosts(completion: @escaping (PostCallback)) {
        let posts = [Post(id: 1, userID: 1, title: "Title 1", body: "Body 1", isFavorite: false, read: false),
                     Post(id: 2, userID: 2, title: "Title 2", body: "Body 2", isFavorite: false, read: false),
                     Post(id: 3, userID: 3, title: "Title 3", body: "Body 3", isFavorite: true, read: true)]
        completion(posts)
    }
    
    static func getComments(from postId: Int, completion: @escaping (CommentCallback)) {
        let comments = [Comment(id: 1, postId: 1, name: "Comment 1", email: "l@l.c", body: "Body comment 1"),
                        Comment(id: 2, postId: 1, name: "Comment 2", email: "l@l.c", body: "Body comment 2"),
                        Comment(id: 3, postId: 2, name: "Comment 3", email: "l@l.c", body: "Body comment 3")]
        completion(comments.filter { $0.postId == postId })
    }
    
    static func getUsers(_ id: Int, completion: @escaping (UserCallback)) {
        let users = [User(id: 1, name: "Luis", username: "lramirezsuarez", email: "l@l.c", phone: "1234567890"),
                     User(id: 2, name: "Alejandro", username: "alejito123", email: "a@l.c", phone: "666777666"),
                     User(id: 3, name: "Pedro", username: "pedroperez", email: "p@l.c", phone: "111222111222")]
        completion(users.filter { $0.id == 1 })
    }
}
