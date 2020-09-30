//
//  Config.swift
//  chronograph
//
//  Created by Sandilya Jandhyala on 14/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import Foundation

class Config {
    static func lookupKey(key: String) -> Any? {
        return Bundle.main.object(forInfoDictionaryKey: key)
    }
    
    static func serverURL() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "SERVER_URL") as! String
    }
    
    static func userInfoURL() -> String {
        return Config.serverURL() + "/api/users/me"
    }
    
    static func loginPageURL() -> String {
        return Config.serverURL() + "?client-type=desktop"
    }
    
    static func organizationsURL() -> String {
        return Config.serverURL() + "/api/organizations/"
    }
    
    static func callbackURLScheme() -> String {
        return Config.lookupKey(key: "CALLBACK_URL_SCHEME") as! String
    }
    
    static func popoverWidth() -> Int {
        return lookupKey(key: "POPOVER_WIDTH") as! Int
    }
    
    static func popoverHeight() -> Int {
        return lookupKey(key: "POPOVER_HEIGHT") as! Int
    }
}
