//
//  Comment.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import Foundation
import RealmSwift

struct Comment: Codable, Identifiable {
    var id: Int
    var postId: Int
    var name: String
    var email: String
    var body: String
}

// MARK: - RealmComment
final class CommentObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var postId = 0
    @objc dynamic var name = ""
    @objc dynamic var email = ""
    @objc dynamic var body = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Persistance for the comment
extension Comment: Persistable {
    public init(managedObject: CommentObject) {
        id = managedObject.id
        postId = managedObject.postId
        name = managedObject.name
        email = managedObject.email
        body = managedObject.body
    }
    
    public func managedObject() -> CommentObject {
        let commentObject = CommentObject()
        commentObject.id = id
        commentObject.postId = postId
        commentObject.name = name
        commentObject.email = email
        commentObject.body = body
        
        return commentObject
    }
}
