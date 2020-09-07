//
//  HomeView.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 08/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.store) var store: Store;
    
    @State var currentUser: User! = nil;
    
    var body: some View {
        return VStack {
            if self.currentUser != nil {
                Text("Hello \(currentUser?.name ?? "Default")!")
            } else {
                LoginView()
            }
        }.onReceive(store.currentUser()) { user in
            self.currentUser = user
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

