//
//  Store.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 03/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Combine

class Store: ObservableObject {
    @Published private var appState: AppState;
    
    init(appState: AppState) {
        self.appState = appState;
    }
    
    func currentUser() -> AnyPublisher<User?, Never> {
        return $appState
            .map(\.currentUser)
            .eraseToAnyPublisher()
    }
    
    func loginUser() {
        print("LOGIN");
        appState.currentUser = User(id: 1, name: "Test");
    }
}
