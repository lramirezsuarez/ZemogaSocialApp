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
    let postStore = PostStore()
    
    var body: some View {
        ZStack {
            VStack {
                List {
                    if self.posts.count > 0 {
                        ForEach(self.posts) { post in
                            NavigationLink(destination: PostDetailView(post: post)) {
                                PostRow(post: post)
                            }
                        }.onDelete(perform: deletePost)
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
                
                HStack(alignment: .center) {
                    Spacer()
                    Button(action: {
                        self.deleteAll()
                    }, label: {
                        Text("Delete All").foregroundColor(Color.white)
                    })
                        .frame(height: 30.0)
                    Spacer()
                }
                .cornerRadius(15)
                .background(Color.red)
            }
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
            self.posts = userPosts
        }
    }
    
    func deletePost(at offsets: IndexSet) {
        var postsToDelete = [PostObject]()
        for i in offsets {
            postsToDelete.append(posts[i].managedObject())
        }
        
        postStore.delete(postsToDelete) { deleted in
            guard deleted else {
                return
            }
            self.posts.remove(atOffsets: offsets)
        }
    }
    
    func deleteAll() {
        postStore.deleteAll { deleted in
            self.posts.removeAll()
        }
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
