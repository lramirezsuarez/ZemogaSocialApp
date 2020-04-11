//
//  UserStore.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import Foundation
import RealmSwift

final class UserStore {
    var realm: Realm?
    
    public func saveUser(_ user: UserObject) throws {
        if realm != nil {
            try! realm!.write {
                realm!.add(user)
            }
        } else {
            throw RuntimeError.NoRealmSet
        }
        
    }
    
    public func saveUsers(_ users: [User]) {
        do {
            try users.forEach({ user in
                do {
                    try saveUser(user.managedObject())
                } catch RuntimeError.NoRealmSet {
                    print(RuntimeError.NoRealmSet.localizedDescription)
                }
            })
        } catch {
            print("Unexpected error")
        }
    }
    
    public func retrieveUsers(_ id: Int) throws -> Results<UserObject> {
        if realm != nil {
            return realm!.objects(UserObject.self).filter("id = %i", id)
        } else {
            throw RuntimeError.NoRealmSet
        }
    }
    
    public func retrieveUsers() throws -> Results<UserObject> {
        if realm != nil {
            return realm!.objects(UserObject.self)
        } else {
            throw RuntimeError.NoRealmSet
        }
    }
    
    public func loadUsersFromRealm(_ id: Int, completion: @escaping UserCallback) {
        realm = try! Realm()
        
        guard let realmUsers = try? retrieveUsers(id) else {
            completion(nil)
            return
        }
        
        let users = Array(realmUsers).map { User(managedObject: $0) }
        
        completion(users)
    }
    
    func deleteAll(completion: @escaping (DeleteHandler)) {
        realm = try! Realm()
        
        try! realm!.write {
            realm!.delete(realm!.objects(UserObject.self))
        }
        completion(true)
    }
}
