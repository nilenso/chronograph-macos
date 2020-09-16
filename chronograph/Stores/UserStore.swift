//
//  UserStore.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 28/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Combine
import AuthenticationServices

class UserStore: ObservableObject {
    @Published var currentUser: User! = nil;
    
    var viewController: ViewController!;
    
    init() {
        viewController = ViewController(rootView: ContentView(userStore: self));
    }
    
    func login() {
        guard let authURL = URL(string: "http://localhost:8000/") else { return };
        let scheme = "chronograph";
        
        print("Login");
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme) {
            callbackURL, error in
            
            
        }
        
        session.presentationContextProvider = viewController;
        
        session.start()
    }
}
