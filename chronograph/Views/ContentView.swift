//
//  ContentView.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 20/08/20.

//
import SwiftUI
import Darwin

struct ContentView: View {
    let store: Store

    var body: some View {
        return VStack { HomeView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .environment(\.store, store)

            Button("Exit", action: {() -> Void in exit(0)})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(appState: AppState()))
    }
}

struct StoreKey: EnvironmentKey {
    typealias Value = Store

    static var defaultValue: Store = Store(appState: AppState())
}

extension EnvironmentValues {
    var store: Store {
        get { self[StoreKey.self] }
        set { self[StoreKey.self] = newValue }
    }
}
