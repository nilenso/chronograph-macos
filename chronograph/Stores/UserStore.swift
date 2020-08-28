//
//  UserStore.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 28/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Combine
import Foundation

class UserStore: ObservableObject {
    @Published var currentUser: User! = nil;
    
    init() {
        currentUser = User(id: 1, name: "Name");
    }
}
