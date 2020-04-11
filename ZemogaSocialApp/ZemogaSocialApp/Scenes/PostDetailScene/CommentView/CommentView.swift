//
//  CommentView.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import SwiftUI
import ActivityIndicatorView

struct CommentView: View {
    @State private var comments = [Comment]()
    @State private var isLoadingComments = true
    var postId: Int
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                if self.comments.count > 0 {
                    ForEach(self.comments) { comment in
                        CommentRow(comment: comment)
                    }
                } else if !self.isLoadingComments && self.comments.count == 0 {
                    Text("No comments to shows".uppercased())
                        .font(.title)
                        .multilineTextAlignment(.center)
                }
            }.onAppear(perform: self.loadComments)
            ActivityIndicatorView(isVisible: $isLoadingComments, type: .rotatingDots)
                .frame(width: 50.0, height: 50.0)
        }
    }
    
    func loadComments() {
        DataRequest.getComments(from: postId) { comments in
            self.isLoadingComments = false
            guard let retrievedComments = comments else {
                return
            }
            
            self.comments = retrievedComments
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(postId: 1)
    }
}
