//
//  CommentStoreTest.swift
//  ZemogaSocialAppTests
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import XCTest
import RealmSwift
@testable import ZemogaSocialApp

class CommentStoreTest: XCTestCase {
    
    let commentStore = CommentStore()

    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
            
        let realm = try! Realm()
        commentStore.realm = realm
    }

    override func tearDown() {
        commentStore.deleteAll() { _ in }
    }
    
    func testSaveAndRetrieveComment() {
        let comment = Comment(id: 1, postId: 1, name: "Comment", email: "l@l.c", body: "This is the body of the comment.")
        
        do {
            try commentStore.saveComment(comment.managedObject())
            let savedComments = try commentStore.retrieveComments()
            XCTAssert(savedComments.count == 1, "Something failed retrieving the comment.")
            
            XCTAssert(savedComments.first?.name == "Comment", "Wrong comment retrieved.")
        } catch RuntimeError.NoRealmSet {
            XCTAssert(false, "No realm database was set")
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }

    func testRetrieveComments() {
        let comments = [Comment(id: 1, postId: 1, name: "Comment 1", email: "l@l.c", body: "This is the body of the comment 1."),
                       Comment(id: 2, postId: 1, name: "Comment 2", email: "l@l.c", body: "This is the body of the comment 2."),
                       Comment(id: 3, postId: 1, name: "Comment 3", email: "l@l.c", body: "This is the body of the comment 3.")
        ]

        commentStore.saveComments(comments)

        do {
            let retrievedComments = try commentStore.retrieveComments()
            XCTAssert(comments.count == retrievedComments.count, "Different amount of comments saved.")
        } catch RuntimeError.NoRealmSet {
            XCTAssert(false, "No realm database was set")
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }
    
    func testDeleteComments() {
        let comments = [Comment(id: 1, postId: 1, name: "Comment 1", email: "l@l.c", body: "This is the body of the comment 1."),
                       Comment(id: 2, postId: 1, name: "Comment 2", email: "l@l.c", body: "This is the body of the comment 2."),
                       Comment(id: 3, postId: 1, name: "Comment 3", email: "l@l.c", body: "This is the body of the comment 3.")
        ]

        commentStore.saveComments(comments)
        commentStore.deleteAll { _ in }

        do {
            let retrievedComments = try commentStore.retrieveComments()
            XCTAssert(retrievedComments.count == 0, "The comments were not deleted.")
        } catch RuntimeError.NoRealmSet {
            XCTAssert(false, "No realm database was set")
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }

}
