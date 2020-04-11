//
//  CommentRow.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import SwiftUI

struct CommentRow: View {
    var comment: Comment
    
    var body: some View {
        VStack {
            HStack {
                Text("\(comment.name) - \(comment.email)").font(.headline)
                Spacer()
            }
            Text(comment.body).multilineTextAlignment(.leading).font(.body)
            Spacer()
        }
    }
}

struct CommentRow_Previews: PreviewProvider {
    static var previews: some View {
        CommentRow(comment: Comment(id: 1, postId: 1, name: "Comment name", email: "l@l.c", body: "This is the body of the comment"))
    }
}
