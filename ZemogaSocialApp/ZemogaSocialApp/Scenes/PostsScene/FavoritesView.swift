//
//  FavoritesView.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 10/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import SwiftUI
import ActivityIndicatorView

struct FavoritesView: View {
    @State private var isLoading = true
    @State private var posts = [Post]()
    
    var body: some View {
        ZStack {
            List {
                if self.posts.count > 0 {
                    ForEach(self.posts) { post in
                        NavigationLink(destination: PostDetailView(post: post)) {
                            PostRow(post: post)
                        }
                    }
                } else if !self.isLoading && self.posts.count == 0 {
                    Text("No posts to shows".uppercased())
                        .font(.title)
                        .multilineTextAlignment(.center)
                }
            }
            .onAppear(perform: self.loadData)
            .navigationBarTitle("Favorites Posts", displayMode: .large)
            ActivityIndicatorView(isVisible: $isLoading, type: .rotatingDots)
                .frame(width: 50.0, height: 50.0)
        }
    }
    
    func loadData() {
        DataRequest.getPosts { retrievedPosts in
            self.isLoading = false
            guard let userPosts = retrievedPosts else {
                return
            }
            self.posts = self.filterFavorites(posts: userPosts)
        }
    }
    
    func filterFavorites(posts: [Post]) -> [Post] {
        return posts.filter { $0.isFavorite }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
