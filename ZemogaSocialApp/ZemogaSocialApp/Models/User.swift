//
//  User.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
}

// MARK: - RealmUser
final class UserObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var username = ""
    @objc dynamic var email = ""
    @objc dynamic var phone = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Persistance for the user
extension User: Persistable {
    public init(managedObject: UserObject) {
        id = managedObject.id
        name = managedObject.name
        username = managedObject.username
        email = managedObject.email
        phone = managedObject.phone
    }
    
    public func managedObject() -> UserObject {
        let userObject = UserObject()
        userObject.id = id
        userObject.name = name
        userObject.username = username
        userObject.email = email
        userObject.phone = phone
        
        return userObject
    }
}
