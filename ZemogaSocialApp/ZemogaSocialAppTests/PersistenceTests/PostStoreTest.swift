//
//  PoststoreTest.swift
//  ZemogaSocialAppTests
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import XCTest
import RealmSwift
@testable import ZemogaSocialApp

class PostStoreTest: XCTestCase {
    
    let postStore = PostStore()

    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
            
        let realm = try! Realm()
        postStore.realm = realm
    }

    override func tearDown() {
        postStore.deleteAll() { _ in }
    }
    
    func testSaveAndRetrievePost() {
        let post = Post(id: 1, userID: 1, title: "Title", body: "Body of the post", isFavorite: true, read: true)
        
        do {
            try postStore.savePost(post.managedObject())
            let savedPosts = try postStore.retrievePost(1)
            XCTAssert(savedPosts.count == 1, "Something failed retrieving the user.")
            
            XCTAssert(savedPosts.first?.title == "Title", "Wrong user retrieved.")
        } catch RuntimeError.NoRealmSet {
            XCTAssert(false, "No realm database was set")
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }

    func testRetrievePosts() {
        let posts = [Post(id: 1, userID: 1, title: "Title 1", body: "Body of the post 1", isFavorite: true, read: true),
                     Post(id: 2, userID: 1, title: "Title 2", body: "Body of the post 2", isFavorite: true, read: true),
                     Post(id: 3, userID: 2, title: "Title 3", body: "Body of the post 3", isFavorite: true, read: true)]

        postStore.savePosts(posts)

        do {
            let retrievedPosts = try postStore.retrievePosts()
            XCTAssert(posts.count == retrievedPosts.count, "Different amount of posts saved.")
        } catch RuntimeError.NoRealmSet {
            XCTAssert(false, "No realm database was set")
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }

    func testMarkAsRead() {
        let post = Post(id: 1, userID: 1, title: "Title", body: "Body of the post", isFavorite: true, read: false)
        
        do {
            try postStore.savePost(post.managedObject())
            postStore.markAsRead(post.managedObject())
            
            let savedPosts = try postStore.retrievePost(1)
            guard let savedPost = savedPosts.first else {
                XCTAssert(false, "Could not retrieve the expected post")
                return
            }
            XCTAssertTrue(savedPost.read, "Something failed retrieving the post.")
        } catch RuntimeError.NoRealmSet {
            XCTAssert(false, "No realm database was set")
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }
    
    func testSetFavorite() {
        let post = Post(id: 1, userID: 1, title: "Title", body: "Body of the post", isFavorite: false, read: false)
        
        do {
            try postStore.savePost(post.managedObject())
            postStore.setFavorite(post.managedObject(), isFavorite: true)
            
            let savedPosts = try postStore.retrievePost(1)
            guard let savedPost = savedPosts.first else {
                XCTAssert(false, "Could not retrieve the expected post")
                return
            }
            XCTAssertTrue(savedPost.isFavorite, "Something failed retrieving the post.")
        } catch RuntimeError.NoRealmSet {
            XCTAssert(false, "No realm database was set")
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }
    
    
    func testDeletePost() {
        let posts = [Post(id: 1, userID: 1, title: "Title 1", body: "Body of the post 1", isFavorite: true, read: true),
                     Post(id: 2, userID: 1, title: "Title 2", body: "Body of the post 2", isFavorite: true, read: true),
                     Post(id: 3, userID: 2, title: "Title 3", body: "Body of the post 3", isFavorite: true, read: true)]

        postStore.savePosts(posts)
        
        let postsToDelete = posts.dropLast()
        postStore.delete(postsToDelete.map{ $0.managedObject() }) { _ in }
        
        do {
            let retrievedPosts = try postStore.retrievePosts()
            XCTAssert(retrievedPosts.count != posts.count, "The post was not deleted.")
        } catch RuntimeError.NoRealmSet {
            XCTAssert(false, "No realm database was set")
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }
    
    func testDeletePosts() {
        let posts = [Post(id: 1, userID: 1, title: "Title 1", body: "Body of the post 1", isFavorite: true, read: true),
                     Post(id: 2, userID: 1, title: "Title 2", body: "Body of the post 2", isFavorite: true, read: true),
                     Post(id: 3, userID: 2, title: "Title 3", body: "Body of the post 3", isFavorite: true, read: true)]

        postStore.savePosts(posts)
        postStore.deleteAll { _ in }
        
        do {
            let retrievedPosts = try postStore.retrievePosts()
            XCTAssert(retrievedPosts.count == 0, "The posts were not deleted.")
        } catch RuntimeError.NoRealmSet {
            XCTAssert(false, "No realm database was set")
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }
}
