//
//  PostStore.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import Foundation
import RealmSwift

enum RuntimeError: Error {
    case NoRealmSet
}

typealias DeleteHandler = (Bool) -> Void

final class PostStore {
    var realm: Realm?
    
    public func savePost(_ post: PostObject) throws {
        if realm != nil {
            try! realm!.write {
                realm!.add(post)
            }
        } else {
            RuntimeError.NoRealmSet
        }
        
    }
    
    public func savePosts(_ posts: [Post]) {
        do {
            try posts.forEach({ post in
                do {
                    try savePost(post.managedObject())
                } catch RuntimeError.NoRealmSet {
                    print(RuntimeError.NoRealmSet.localizedDescription)
                }
            })
        } catch {
            print("Unexpected error")
        }
    }
    
    public func retrievePosts() throws -> Results<PostObject> {
        if realm != nil {
            return realm!.objects(PostObject.self)
        } else {
            throw RuntimeError.NoRealmSet
        }
    }
    
    public func retrievePost(_ id: Int) throws -> Results<PostObject> {
        if realm != nil {
            return realm!.objects(PostObject.self).filter("id = %i", id)
        } else {
            throw RuntimeError.NoRealmSet
        }
    }
    
    public func loadPostsFromRealm(completion: @escaping PostCallback) {
        realm = try! Realm()
        
        guard let realmPosts = try? retrievePosts() else {
            completion(nil)
            return
        }
        
        let posts = Array(realmPosts).map { Post(managedObject: $0) }
        
        completion(posts)
    }
    
    func markAsRead(_ post: PostObject) {
        realm = try! Realm()
        
        let posts = try! retrievePost(post.id)
        try! realm!.write {
            posts.setValue(true, forKey: "read")
        }
    }
    
    func setFavorite(_ post: PostObject, isFavorite: Bool) {
        realm = try! Realm()
        
        let posts = try! retrievePost(post.id)
        try! realm!.write {
            posts.setValue(isFavorite, forKey: "isFavorite")
        }
    }
    
    func delete(_ posts: [PostObject], completion: @escaping (DeleteHandler)) {
        realm = try! Realm()
        
        posts.forEach { post in
            try! realm!.write {
                realm!.delete(realm!.objects(PostObject.self).filter("id=%i", post.id))
            }
        }
        completion(true)
    }
    
    func deleteAll(completion: @escaping (DeleteHandler)) {
        realm = try! Realm()
        
        try! realm!.write {
            realm!.delete(realm!.objects(PostObject.self))
        }
        completion(true)
    }
}
