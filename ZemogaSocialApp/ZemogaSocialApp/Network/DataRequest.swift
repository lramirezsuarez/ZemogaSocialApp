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

protocol DataRequestProtocol {
    static func getPosts(completion: @escaping (PostCallback))
}

struct DataRequest: DataRequestProtocol {

    static func getPosts(completion: @escaping (PostCallback)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
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
                
                completion(networkPosts)
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
}