//
//  ContentView.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 20/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userStore = UserStore();
    
    var body: some View {
        return VStack {
            if userStore.currentUser != nil {
                Text("Hello!")
            } else {
                LoginView()
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
