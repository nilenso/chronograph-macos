//
//  AppState.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 03/09/20.

//
struct AppState {
    var currentUser: User!
    var credentials: Credentials!
    var organizations: [Organization] = []
    var timers: [Timer] = []
    var tasks: [Task] = []
}
