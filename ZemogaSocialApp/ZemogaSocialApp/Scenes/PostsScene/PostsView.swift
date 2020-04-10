//
//  PostsView.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 10/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import SwiftUI
import ActivityIndicatorView

struct PostsView: View {
    @State private var isLoading = true
    @State var posts = [Post]()
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    if self.posts.count > 0 {
                        ForEach(self.posts) { post in
                            PostRow(post: post)
                        }
                    } else if !self.isLoading && self.posts.count == 0 {
                        Text("No posts to shows".uppercased())
                            .font(.title)
                            .multilineTextAlignment(.center)
                    }
                }
                .onAppear(perform: self.loadData)
                .navigationBarTitle("All Posts", displayMode: .large)
                .navigationBarItems(trailing:
                    Button(action: {
                        self.isLoading = true
                        self.loadData()
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                            .padding(.trailing, 12)
                    }))
                .listSeparatorStyleNone()
                
                ActivityIndicatorView(isVisible: $isLoading, type: .rotatingDots)
                    .frame(width: 50.0, height: 50.0)
            }
        }
        
    }
    
    func loadData() {
        DataRequest.getPosts { retrievedPosts in
            self.isLoading = false
            guard let userPosts = retrievedPosts else {
                return
            }
            self.posts = userPosts
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
