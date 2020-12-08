//
//  Store.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 03/09/20.

//
import Alamofire
import Combine
import AuthenticationServices

class Store: ObservableObject {
    @Published private var appState: AppState

    weak var presentationContext: ViewController!

    var managedObjectContext: NSManagedObjectContext! {
        didSet {
            startCoreDataSync()
        }
    }

    var fetchUserCancellable: AnyCancellable!
    var fetchTimersCancellable: AnyCancellable!
    var fetchOrganizationsCancellable: AnyCancellable!
    var syncCoreDataCancellable: AnyCancellable!

    init(appState: AppState) {
        self.appState = appState
        let storedCredentials = self.fetchTokenFromKeychain()

        if storedCredentials != nil {
            self.appState.credentials = storedCredentials
        }
    }

    func startCoreDataSync() {
        syncCoreDataCancellable = NotificationCenter.default
            .publisher(for: .NSManagedObjectContextDidSave, object: self.managedObjectContext)
            .map { _ -> [Organization] in
                let request: NSFetchRequest<OrganizationCD> = NSFetchRequest(entityName: "OrganizationCD")
                try! print(self.managedObjectContext.fetch(request))
                return try! self.managedObjectContext.fetch(request).map(Organization.init)
            }.sink { organizations in
                print(organizations)
                self.appState.organizations = organizations
            }
    }
        
    func credentials() -> AnyPublisher<Credentials?, Never> {
        return $appState
            .map(\.credentials)
            .eraseToAnyPublisher()
    }

    func currentUser() -> AnyPublisher<User?, Never> {
        return $appState
            .map(\.currentUser)
            .eraseToAnyPublisher()
    }

    func storeTokenInKeychain(token: String) -> Bool {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: "chronograph-application-token",
                                    kSecAttrServer as String: Config.serverURL(),
                                    kSecValueData as String: token.data(using: .utf8)!]
        let status = SecItemAdd(query as CFDictionary, nil)

        if status == errSecDuplicateItem {
            debugPrint("Duplicate item when storing credentials in keychain")
            return false
        }

        return status == errSecSuccess
    }

    func fetchTokenFromKeychain() -> Credentials? {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecReturnData as String: kCFBooleanTrue!,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecAttrServer as String: Config.serverURL(),
                                    kSecAttrAccount as String: "chronograph-application-token"]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { return nil }
        guard status == errSecSuccess else { return nil }

        guard let secItem = item as? Data else {
            debugPrint("Could not fetch credentials from keychain")
            return nil
        }

        guard let token = String(data: secItem, encoding: .utf8) else {
            debugPrint("Could not decode keychain credentials")
            return nil
        }

        return Credentials(token: token)
    }

    func deleteTokenFromKeychain() -> Bool {
        let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                    kSecAttrAccount as String: "chronograph-application-token",
                                    kSecAttrServer as String: Config.serverURL()]
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }

    func loginUser() {
        let authURL = URL(string: Config.loginPageURL())!

        let subject = CurrentValueSubject<String?, Never>(nil)
        fetchUserCancellable = subject
            .compactMap {v in v}
            .receive(on: DispatchQueue.main)
            .map { accessToken in
                self.appState.credentials = Credentials(token: accessToken)
                self.storeTokenInKeychain(token: accessToken)

                accessToken
            }
            .flatMap { _ in
                UserAPI(credentials: self.appState.credentials).me()
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

    func logout() -> Bool {
        guard self.deleteTokenFromKeychain() else { return false; }

        self.appState.credentials = nil
        self.appState.currentUser = nil

        return true
    }

    func getOrganizations() {
        guard let credentials = self.appState.credentials else {
            debugPrint("Missing access token when fetching organizations")
            return
        }

        let organizationApi = OrganizationApi.init(credentials: credentials)
        fetchOrganizationsCancellable = organizationApi.list().sink { result in
            switch result {
            case .failure(let error):
                debugPrint("Error while fetching organizations", error.errorDescription as Any)
            case .success(let organizations):
                _ = try! Organization.removeAll(context: self.managedObjectContext, objects: [])
                _ = try! Organization.batchInsert(
                    context: self.managedObjectContext,
                    objects: organizations
                )

                try! self.managedObjectContext.save()
            }
        }
    }

    func getTimers() {
        guard let credentials = self.appState.credentials else {
            debugPrint("Missing access token when fetching timers")
            return
        }
        
        let timerApi = TimerAPI.init(credentials: credentials)
        fetchTimersCancellable = timerApi.listByDate(recordedFor: Date()).sink {result in
            switch result {
            case .failure(let error):
                debugPrint("Error while fetching timers", error)
            case .success(let timersWithTasks):
                self.appState.timers = timersWithTasks.map {timerWithTask in
                    timerWithTask.withoutTask()
                }
                self.appState.tasks = timersWithTasks.map(\.task)
            }
        }
    }
    
    func organizations() -> AnyPublisher<[Organization], Never> {
        
        return $appState
            .map(\.organizations)
            .eraseToAnyPublisher()
    }
    
    func timers() -> AnyPublisher<[Timer], Never> {
        return $appState
            .map(\.timers)
            .eraseToAnyPublisher()
    }
    
    func taskForTimer(timer: Timer) -> Task? {
        self.appState.tasks.filter { task in
            task.id == timer.taskID
        }.first
    }
    
    func timersForOrganizationID(orgID: Int) -> AnyPublisher<[Timer], Never> {
        return $appState
            .map(\.timers)
            .map  { timersList in
                timersList.filter { timer in
                    guard let task = self.taskForTimer(timer: timer) else {
                        return false
                    }
                    return task.organizationID == orgID
                }
            }
            .eraseToAnyPublisher()
    }
}
