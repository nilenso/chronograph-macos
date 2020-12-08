//
//  LoginView.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 28/08/20.

//

import SwiftUI

struct LoginView: View {
    @Environment(\.store) var store: Store

    var body: some View {
        Button(action: {
            self.store.loginUser()
        }) {
            Text("Login")
        }
    }
}
