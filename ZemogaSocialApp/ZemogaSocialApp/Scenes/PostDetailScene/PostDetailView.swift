//
//  PostDetailView.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import SwiftUI
import ActivityIndicatorView

struct PostDetailView: View {
    @State private var isFavorite = false
    var post: Post
    
    var body: some View {
        List {
            Section(header: Text("Content")) {
                Text(post.body.capitalized).font(.body).multilineTextAlignment(.leading)
            }
            
            Section(header: Text("User")) {
                UserView(userID: post.userID)
            }
            
            Section(header: Text("Comments")) {
                CommentView(postId: post.id)
            }
        }
        .onAppear(perform: {
            self.markAsRead()
            self.isFavorite = self.post.isFavorite
        })
        .listSeparatorStyleNone()
        .listStyle(DefaultListStyle())
        .navigationBarTitle(Text(post.title), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.markAsFavorite()
        }, label: {
            Image(systemName: self.isFavorite ? "star.fill" : "star")
                .padding(.trailing, 12)
                .foregroundColor(Color.yellow)
        }))
    }
    
    func markAsRead() {
        DataRequest.postStore.markAsRead(post.managedObject())
    }
    
    func markAsFavorite() {
        self.isFavorite = !self.post.isFavorite
        DataRequest.postStore.setFavorite(post.managedObject(), isFavorite: self.isFavorite)
    }
    
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: Post(id: 1, userID: 1, title: "This is the title", body: "This is the body, with a lot of text that I wrote myself to fill all the text area, so here it is.", isFavorite: false, read: true))
    }
}
