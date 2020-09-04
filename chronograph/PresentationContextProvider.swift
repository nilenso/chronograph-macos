//
//  ViewController.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 31/08/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import SwiftUI
import AuthenticationServices

class PresentationContextProvider: NSObject {}

extension PresentationContextProvider: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return NSWindow()
    }
}
