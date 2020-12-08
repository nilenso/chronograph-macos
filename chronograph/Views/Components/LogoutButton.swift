//
//  LogoutButton.swift
//  chronograph
//
//  Created by Ravi Chandra Padmala on 22/10/20.

//

import SwiftUI

struct LogoutButton: View {
    @Environment(\.store) var store: Store

    var body: some View {
        Button("Logout", action: { () -> Void in
            if !self.store.logout() {
                debugPrint("Logout failed")
            }
        })
    }
}

struct LogoutButton_Previews: PreviewProvider {
    static var previews: some View {
        LogoutButton()
    }
}
