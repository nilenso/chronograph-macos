//
//  Store.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 03/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//
import Alamofire
import Combine
import AuthenticationServices

class Store: ObservableObject {
    @Published private var appState: AppState;
    weak var presentationContext: ViewController!;
    
    var cancellable: AnyCancellable!
    
    init(appState: AppState) {
        self.appState = appState;
    }
    
    func currentUser() -> AnyPublisher<User?, Never> {
        return $appState
            .map(\.currentUser)
            .eraseToAnyPublisher()
    }
    
    func loginUser() {
        let authURL = URL(string: Config.loginPageURL())!
        
        let subject = CurrentValueSubject<String?, Never>(nil);
        cancellable = subject
            .compactMap {v in v}
            .receive(on: DispatchQueue.main)
            .map {accessToken in
                self.appState.accessToken = accessToken
                return accessToken
        }
        .flatMap { accessToken in
            UserAPI(accessToken: accessToken).me()
        }
        .sink { result in
            switch(result) {
            case .failure(let error):
                debugPrint("Error while fetching user information!", error.errorDescription)
            case.success(let user):
                self.appState.currentUser = user
                return
            }
        }
    
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: Config.callbackURLScheme())
        { callbackURL, error in
            guard error == nil, let callbackURL = callbackURL else { return }
            
            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
            let accessToken = queryItems?.filter({ $0.name == "access-token" }).first?.value
            subject.send(accessToken)
        }
        session.presentationContextProvider = self.presentationContext;
        
        session.start()
    }
}
