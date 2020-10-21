//
//  HomeView.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 08/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.store) var store: Store

    @State var currentUser: User! = nil
    @State var credentials: Credentials! = nil

    var body: some View {
        return VStack {
            if self.credentials != nil {
                VStack {
                    Text("Hello \(currentUser?.name ?? "Default")!")
                    OrganizationsView()
                }
            } else {
                LoginView()
            }
        }
        .onReceive(store.credentials()) {
            credentials in self.credentials = credentials
        }
        .onReceive(store.currentUser()) { user in
            self.currentUser = user
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
