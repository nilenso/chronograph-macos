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
    @Published private var appState: AppState

    weak var presentationContext: ViewController!

    var managedObjectContext: NSManagedObjectContext!

    var cancellable: AnyCancellable!

    var fetchOrganizationsCancellable: AnyCancellable!

    init(appState: AppState) {
        self.appState = appState
    }

    func currentUser() -> AnyPublisher<User?, Never> {
        return $appState
            .map(\.currentUser)
            .eraseToAnyPublisher()
    }

    func loginUser() {
        let authURL = URL(string: Config.loginPageURL())!

        let subject = CurrentValueSubject<String?, Never>(nil)
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
            switch result {
            case .failure(let error):
                debugPrint("Error while fetching user information!", error.errorDescription)
            case .success(let user):
                self.appState.currentUser = user
                return
            }
        }

        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: Config.callbackURLScheme()) { callbackURL, error in
            guard error == nil, let callbackURL = callbackURL else { return }

            let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
            let accessToken = queryItems?.filter({ $0.name == "access-token" }).first?.value
            subject.send(accessToken)
        }
        session.presentationContextProvider = self.presentationContext

        session.start()
    }

    func getOrganizations() {
        let organizationApi = OrganizationApi.init(accessToken: self.appState.accessToken)
        cancellable = organizationApi.list().sink { result in
            switch result {
            case .failure(let error):
                debugPrint("Error while fetching organizations", error.errorDescription)
            case .success(let organizations):
                let success = try! Organization.batchInsert(
                    context: self.managedObjectContext,
                    objects: organizations
                )

                try! self.managedObjectContext.save()
            }
        }
    }

    func organizations() -> AnyPublisher<[Organization], Never> {
        fetchOrganizationsCancellable = NotificationCenter.default
            .publisher(for: .NSManagedObjectContextDidSave, object: self.managedObjectContext)
            .map { _ -> [Organization] in
                let request: NSFetchRequest<OrganizationCD> = NSFetchRequest(entityName: "OrganizationCD")
                try! print(self.managedObjectContext.fetch(request))
                return try! self.managedObjectContext.fetch(request).map(Organization.init)
            }.sink { organizations in
                print(organizations)
                self.appState.organizations = organizations
            }
        return $appState
            .map(\.organizations)
            .eraseToAnyPublisher()
    }
}
