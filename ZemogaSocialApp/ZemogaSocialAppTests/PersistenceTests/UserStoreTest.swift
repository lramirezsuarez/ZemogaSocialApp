//
//  UserStoreTest.swift
//  ZemogaSocialAppTests
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import XCTest
import RealmSwift
@testable import ZemogaSocialApp

class UserStoreTest: XCTestCase {
    
    let userStore = UserStore()

    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
            
        let realm = try! Realm()
        userStore.realm = realm
    }

    override func tearDown() {
        userStore.deleteAll() { _ in }
    }
    
    func testSaveAndRetrieveUser() {
        let user = User(id: 20, name: "Prueba", username: "probando123", email: "p@p.c", phone: "1234567890")
        
        do {
            try userStore.saveUser(user.managedObject())
            let savedUsers = try userStore.retrieveUsers(20)
            XCTAssert(savedUsers.count == 1, "Something failed retrieving the user.")
            
            XCTAssert(savedUsers.first?.name == "Prueba", "Wrong user retrieved.")
        } catch RuntimeError.NoRealmSet {
            XCTAssert(false, "No realm database was set")
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }

    func testRetrieveUsers() {
        let users = [User(id: 1, name: "1", username: "1", email: "1", phone: "1"),
                     User(id: 2, name: "2", username: "2", email: "2", phone: "2"),
                     User(id: 3, name: "3", username: "3", email: "3", phone: "3")]

        userStore.saveUsers(users)
        
        do {
            let retrievedUsers = try userStore.retrieveUsers()
            XCTAssert(users.count == retrievedUsers.count, "Different amount of users saved.")
        } catch RuntimeError.NoRealmSet {
            XCTAssert(false, "No realm database was set")
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }
    
    func testDeleteUsers() {
        let users = [User(id: 1, name: "1", username: "1", email: "1", phone: "1"),
                     User(id: 2, name: "2", username: "2", email: "2", phone: "2"),
                     User(id: 3, name: "3", username: "3", email: "3", phone: "3")]

        userStore.saveUsers(users)
        userStore.deleteAll { _ in }
        
        do {
            let retrievedUsers = try userStore.retrieveUsers()
            XCTAssert(retrievedUsers.count == 0, "The users were not deleted.")
        } catch RuntimeError.NoRealmSet {
            XCTAssert(false, "No realm database was set")
        } catch {
            XCTAssert(false, "Unexpected error \(error)")
        }
    }

}
