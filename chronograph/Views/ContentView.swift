//
//  ContentView.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 20/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Cleanse
import SwiftUI

struct ContentView: View {
    let store: Store;
    
    var body: some View {
        return HomeView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .environment(\.store, store);
    }
    
    struct Module: Cleanse.Module {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(ContentView.self).to(factory: ContentView.init)
            binder.include(module: Store.Module.self);
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(appState: AppState()))
    }
   
}


struct StoreKey: EnvironmentKey {
    typealias Value = Store;
    
    static var defaultValue: Store = Store(appState: AppState());
}

extension EnvironmentValues {
    var store: Store {
        get { self[StoreKey.self] }
        set { self[StoreKey.self] = newValue }
    }
}
