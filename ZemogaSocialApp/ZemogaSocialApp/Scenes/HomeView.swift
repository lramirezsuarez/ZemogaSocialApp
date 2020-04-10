//
//  ContentView.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 10/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import SwiftUI
import ActivityIndicatorView

struct HomeView: View {
    @State private var posts = [Post]()
    @State private var isLoading = true
    
    var body: some View {
        TabView {
            PostsView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("All")
            }
            FavoritesView()
                .tabItem {
                    Image(systemName: "text.badge.star")
                    Text("Favorites")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
