//
//  DataRequestTest.swift
//  ZemogaSocialAppTests
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import XCTest
@testable import ZemogaSocialApp

class DataRequestTest: XCTestCase {
    
    override func setUp() {
    }
    
    override class func tearDown() {
    }
    
    func testGetPosts() {
        let expectedPosts = Mocks.posts
        var receivedPosts = [Post]()
        
        MockDataRequest.getPosts { posts in
            guard let requestPosts = posts else {
                XCTAssert(false, "Failure receiving the posts.")
                return
            }
            receivedPosts = requestPosts
            XCTAssert(expectedPosts.count == receivedPosts.count, "The posts received are wrong.")
        }
    }
    
    func testGetComments() {
        let expectedComments = Mocks.comments
        var receivedComments = [Comment]()
        
        MockDataRequest.getComments(from: 1) { comments in
            guard let requestComments = comments else {
                XCTAssert(false, "Failure receiving the posts.")
                return
            }
            receivedComments = requestComments
            XCTAssert(expectedComments.count == receivedComments.count, "The posts received are wrong.")
        }
    }
    
    func testGetUsers() {
        let expectedUsers = Mocks.users
        var receivedUsers = [User]()
        
        MockDataRequest.getUsers(1) { users in
            guard let requestUsers = users else {
                XCTAssert(false, "Failure receiving the posts.")
                return
            }
            receivedUsers = requestUsers
            XCTAssert(expectedUsers.count == receivedUsers.count, "The posts received are wrong.")
        }
    }
}
