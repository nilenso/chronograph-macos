//
//  Store.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 03/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//
import Alamofire
import Cleanse
import Combine
import AuthenticationServices

class Store: ObservableObject {
    @Published private var appState: AppState;
    weak var presentationContext: ViewController!;
    
    let SCHEME="chronograph";
    
    init(appState: AppState) {
        self.appState = appState;
    }
    
    func currentUser() -> AnyPublisher<User?, Never> {
        return $appState
            .map(\.currentUser)
            .eraseToAnyPublisher()
    }
    
    func loginUser() {
        guard let authURL = URL(string: "http://localhost:8000?client-type=desktop") else { return }
        let scheme = SCHEME;

        // Initialize the session.
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme)
        { callbackURL, error in
            // TODO: Handle the error
            guard error == nil, let callbackURL = callbackURL else { print(error); return }
            
            print("Making reqeust");
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
            let accessToken = queryItems?.filter({ $0.name == "access-token" }).first?.value
        
            print(accessToken);
            
            let headers: HTTPHeaders = [.authorization(bearerToken: accessToken!)]
            AF.request("http://localhost:8000/api/users/me", headers: headers).response { response in
                debugPrint(response)
            }
        }
        
        session.presentationContextProvider = self.presentationContext;
        
        session.start()
    }
     
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(Store.self)
                .sharedInScope()
                .to(factory: Store.init)
            
            binder.include(module: AppState.Module.self)
        }
    }
    
    struct PresentationContextProvider: Tag {
        typealias Element = ASWebAuthenticationPresentationContextProviding
    }
}
