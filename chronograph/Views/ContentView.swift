//
//  ContentView.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 20/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.store) var store: Store;
    
    @State var currentUser: User! = nil
    
    var body: some View {
        return VStack {
            if currentUser != nil {
                Text("Hello \(currentUser?.name ?? "Default")!")
            } else {
                LoginView()
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .onReceive(store.currentUser()) { user in
            self.currentUser = user
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

