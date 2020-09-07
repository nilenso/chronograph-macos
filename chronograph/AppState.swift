//
//  AppState.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 03/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//
import Cleanse

struct AppState {
    var currentUser: User!;
    
    struct Module: Cleanse.Module  {
        static func configure(binder: Binder<Singleton>) {
            binder.bind(AppState.self)
                .sharedInScope()
                .to(value: AppState())
        }
    }
}
