//
//  CommentStore.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import Foundation
import RealmSwift

final class CommentStore {
    var realm: Realm?
    
    public func saveComment(_ comment: CommentObject) throws {
        if realm != nil {
            try! realm!.write {
                realm!.add(comment)
            }
        } else {
            throw RuntimeError.NoRealmSet
        }
        
    }
    
    public func saveComments(_ comments: [Comment]) {
        do {
            try comments.forEach({ comment in
                do {
                    try saveComment(comment.managedObject())
                } catch RuntimeError.NoRealmSet {
                    print(RuntimeError.NoRealmSet.localizedDescription)
                }
            })
        } catch {
            print("Unexpected error")
        }
    }

    public func retrieveComments(_ postId: Int) throws -> Results<CommentObject> {
        if realm != nil {
            return realm!.objects(CommentObject.self).filter("postId = %i", postId)
        } else {
            throw RuntimeError.NoRealmSet
        }
    }
    
    public func retrieveComments() throws -> Results<CommentObject> {
        if realm != nil {
            return realm!.objects(CommentObject.self)
        } else {
            throw RuntimeError.NoRealmSet
        }
    }
    
    public func loadCommentsFromRealm(with postId: Int, completion: @escaping CommentCallback) {
        realm = try! Realm()
        
        guard let realmComments = try? retrieveComments(postId) else {
            completion(nil)
            return
        }
        
        let comments = Array(realmComments).map { Comment(managedObject: $0) }
        
        completion(comments)
    }
    
    func deleteAll(completion: @escaping (DeleteHandler)) {
        realm = try! Realm()
        
        try! realm!.write {
            realm!.delete(realm!.objects(CommentObject.self))
        }
        completion(true)
    }
}
