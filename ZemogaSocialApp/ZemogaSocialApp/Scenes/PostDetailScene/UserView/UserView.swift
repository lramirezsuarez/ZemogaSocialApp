//
//  UserView.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import SwiftUI
import ActivityIndicatorView

struct UserView: View {
    @State private var isLoadingUser = true
    @State private var users = [User]()
    var userID: Int
    
    var body: some View {
        ZStack {
            VStack {
                if self.users.count > 0 {
                    ForEach(self.users) { user in
                        UserRow(user: user)
                    }
                } else if !self.isLoadingUser && self.users.count == 0 {
                    Text("No user information to show.")
                        .font(.title)
                        .multilineTextAlignment(.center)
                }
            }.onAppear(perform: self.loadUsers)
            HStack {
                Spacer()
                ActivityIndicatorView(isVisible: $isLoadingUser, type: .rotatingDots)
                    .frame(width: 50.0, height: 50.0)
                Spacer()
            }
        }
        
    }
    
    
    func loadUsers() {
        DataRequest.getUsers(userID) { receivedUsers in
            self.isLoadingUser = false
            guard let retrievedUsers = receivedUsers else {
                return
            }
            self.users = retrievedUsers
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(userID: 1)
    }
}
