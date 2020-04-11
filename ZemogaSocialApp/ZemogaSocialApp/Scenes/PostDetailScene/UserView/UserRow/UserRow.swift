//
//  UserRow.swift
//  ZemogaSocialApp
//
//  Created by Luis Ramirez on 11/04/20.
//  Copyright © 2020 Lramirez. All rights reserved.
//

import SwiftUI

struct UserRow: View {
    var user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(user.name) - @\(user.username)")
                Spacer()
            }
            HStack {
                Text("Email: ")
                Text(user.email)
            }
            HStack {
                Text("Phone: ")
                Text(user.phone)
            }
            Spacer()
        }
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRow(user: User(id: 1, name: "Luis", username: "lramirezsuarez", email: "l@l.c", phone: "123445567"))
    }
}
