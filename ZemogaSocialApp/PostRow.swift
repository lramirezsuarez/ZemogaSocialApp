//
//  PostRow.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 10/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import SwiftUI

struct PostRow: View {
    var post: Post
    
    var body: some View {
        VStack {
            HStack {
                if !post.read {
                    Image(systemName: "circle.fill")
                        .foregroundColor(Color.blue)
                }
                if post.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                }
                Text(post.title.capitalized)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                Spacer()
                
            }
        }
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: Post(id: 1, userID: 1, title: "This is the title", body: """
        Loremp upsiisudpso ashid opaosofp oapdfoa paodpfofj padipaodpvv Loremp upsiisudpso ashid opaosofp oapdfoa paodpfofj padipaodpvv Loremp upsiisudpso ashid opaosofp oapdfoa paodpfofj padipaodpvvLoremp upsiisudpso ashid opaosofp oapdfoa paodpfofj padipaodpvv Loremp upsiisudpso ashid opaosofp oapdfoa paodpfofj padipaodpvv Loremp upsiisudpso ashid opaosofp oapdfoa paodpfofj padipaodpvv
        Loremp upsiisudpso ashid opaosofp oapdfoa paodpfofj padipaodpvv
        Loremp upsiisudpso ashid opaosofp oapdfoa paodpfofj padipaodpvvLoremp upsiisudpso ashid opaosofp oapdfoa paodpfofj padipaodpvvLoremp upsiisudpso ashid opaosofp oapdfoa paodpfofj padipaodpvv
        """, isFavorite: true ,read: false))
    }
}
