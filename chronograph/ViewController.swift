//
//  ViewController.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 07/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//
import SwiftUI
import AuthenticationServices

class ViewController: NSHostingController<ContentView> {
    override init(rootView: ContentView) {
        super.init(rootView: rootView)
    }

    @objc required dynamic init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}
