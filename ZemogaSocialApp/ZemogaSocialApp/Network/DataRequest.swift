//
//  DataRequest.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 10/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import Foundation
import RealmSwift

typealias PostCallback = ([Post]?) -> Void
typealias CommentCallback = ([Comment]?) -> Void
typealias UserCallback = ([User]?) -> Void

protocol DataRequestProtocol {
    static func getPosts(completion: @escaping (PostCallback))
    static func getComments(from postId: Int, completion: @escaping (CommentCallback))
    static func getUsers(_ id: Int, completion: @escaping (UserCallback))
}

struct DataRequest: DataRequestProtocol {
    static let postStore = PostStore()
    static let userStore = UserStore()
    static let commentStore = CommentStore()
    
    static func getPosts(completion: @escaping (PostCallback)) {
        postStore.loadPostsFromRealm { realmPosts in
            if let posts = realmPosts, posts.count > 0 {
                completion(posts)
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    loadPostsFromNetwork { posts in
                        guard var networkPosts = posts else {
                            completion(nil)
                            return
                        }
                        for i in 0...networkPosts.count {
                            if i == 20 {
                                break
                            }
                            networkPosts[i].read = false
                        }
                        savePostsToRealm(posts: networkPosts)
                        completion(networkPosts)
                    }
                }
            }
        }
    }
    
    static func getComments(from postId: Int, completion: @escaping (CommentCallback)) {
        commentStore.loadCommentsFromRealm(with: postId) { realmComments in
            if let comments = realmComments, comments.count > 0 {
                completion(comments)
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    loadCommentsFromNetwork(from: postId) { retrievedComments in
                        guard let networkComments = retrievedComments else {
                            completion(nil)
                            return
                        }
                        saveCommentsToRealm(comments: networkComments)
                        completion(networkComments)
                    }
                }
            }
        }
        
    }
    
    static func getUsers(_ id: Int, completion: @escaping (UserCallback)) {
        userStore.loadUsersFromRealm(id) { realmUsers in
            if let users = realmUsers, users.count > 0 {
                completion(users)
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    loadUsersFromNetwork(id) { retrievedUsers in
                        guard let networkUsers = retrievedUsers else {
                            completion(nil)
                            return
                        }
                        saveUsersToRealm(users: networkUsers)
                        completion(networkUsers)
                    }
                }
            }
        }
        
    }
}

// MARK: Implementation
private extension DataRequest {
    static func loadPostsFromNetwork(completion: @escaping (PostCallback)) {
        let jsonDecoder = JSONDecoder()
        
        guard let url = URL(string: Environment.prod.contentBaseURl + "posts"),
            let timeoutInterval = TimeInterval(exactly: 300) else {
                preconditionFailure("Failed to construct URL")
        }
        
        let taskConfiguration = URLSessionConfiguration.default
        taskConfiguration.timeoutIntervalForRequest = timeoutInterval
        
        let urlSession = URLSession(configuration: taskConfiguration)
        let task = urlSession.dataTask(with: url) {
            data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    let postsDecoded = try? jsonDecoder.decode([Post].self, from: data)
                    completion(postsDecoded)
                } else {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
    
    static func savePostsToRealm(posts: [Post]) {
        postStore.realm = try! Realm()
        postStore.savePosts(posts)
    }
    
    static func loadCommentsFromNetwork(from postId: Int, completion: @escaping (CommentCallback)) {
        let jsonDecoder = JSONDecoder()
        
        guard let url = URL(string: Environment.prod.contentBaseURl + "posts/\(postId)/comments"),
            let timeoutInterval = TimeInterval(exactly: 300) else {
                preconditionFailure("Failed to construct URL")
        }
        
        let taskConfiguration = URLSessionConfiguration.default
        taskConfiguration.timeoutIntervalForRequest = timeoutInterval
        
        let urlSession = URLSession(configuration: taskConfiguration)
        let task = urlSession.dataTask(with: url) {
            data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    let commentsDecoded = try? jsonDecoder.decode([Comment].self, from: data)
                    completion(commentsDecoded)
                } else {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
    
    static func saveCommentsToRealm(comments: [Comment]) {
        commentStore.realm = try! Realm()
        commentStore.saveComments(comments)
    }
    
    static func loadUsersFromNetwork(_ id: Int, completion: @escaping (UserCallback)) {
        let jsonDecoder = JSONDecoder()
        
        guard let url = URL(string: Environment.prod.contentBaseURl + "users?id=\(id)"),
            let timeoutInterval = TimeInterval(exactly: 300) else {
                preconditionFailure("Failed to construct URL")
        }
        
        let taskConfiguration = URLSessionConfiguration.default
        taskConfiguration.timeoutIntervalForRequest = timeoutInterval
        
        let urlSession = URLSession(configuration: taskConfiguration)
        let task = urlSession.dataTask(with: url) {
            data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    let usersDecoded = try? jsonDecoder.decode([User].self, from: data)
                    completion(usersDecoded)
                } else {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
    
    static func saveUsersToRealm(users: [User]) {
        userStore.realm = try! Realm()
        userStore.saveUsers(users)
    }
    
}
