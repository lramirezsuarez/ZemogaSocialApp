//
//  Post.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 10/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Post
struct Post: Codable, Identifiable {
    let id: Int
    let userID: Int
    let title: String
    let body: String
    var isFavorite: Bool = false
    var read: Bool = true

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

// MARK: - RealmPost
final class PostObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var userID = 0
    @objc dynamic var title = ""
    @objc dynamic var body = ""
    @objc dynamic var isFavorite = false
    @objc dynamic var read = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Persistance for the post
extension Post: Persistable {
    public init(managedObject: PostObject) {
        id = managedObject.id
        userID = managedObject.userID
        title = managedObject.title
        body = managedObject.body
        isFavorite = managedObject.isFavorite
        read = managedObject.read
    }
    
    public func managedObject() -> PostObject {
        let postObject = PostObject()
        postObject.id = id
        postObject.userID = userID
        postObject.title = title
        postObject.body = body
        postObject.isFavorite = isFavorite
        postObject.read = read
        
        return postObject
    }
}

