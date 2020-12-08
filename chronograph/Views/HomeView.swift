//
//  HomeView.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 08/09/20.

//

import SwiftUI

struct HomeView: View {
    @Environment(\.store) var store: Store

    @State var currentUser: User! = nil
    @State var credentials: Credentials! = nil
    @State var selectedOrgId = 0
    @State var displayedTimers: [Timer] = []
    @State var currentTime = Date()
    let timerPublisher = Foundation.Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private static func padMinutes(_ minutes: Int) -> String {
        if minutes < 10 {
            return "0" + String(minutes)
        } else {
            return String(minutes)
        }
    }
    
    private static func formatTimeInterval(_ t: TimeInterval) -> String {
        let result = Int(t / 60).quotientAndRemainder(dividingBy: 60)
        return String(result.quotient) + ":" + padMinutes(result.remainder)
    }
    
    var body: some View {
        let selectedOrgIdBinding = Binding<Int>(get: {
            self.selectedOrgId
        }, set: {
            self.selectedOrgId = $0
            self.store.getTimers()
        })
        
        return VStack {
            if self.credentials != nil {
                VStack {
                    Text("Hello \(currentUser?.name ?? "Default")!")
                    OrganizationSelect(orgIDSelection: selectedOrgIdBinding)
                    ForEach(displayedTimers, id: \.id) { timer in
                        Text((store.taskForTimer(timer: timer)?.name ?? "")
                                + " "
                                + HomeView.formatTimeInterval(timer.totalDuration(currentTime: currentTime)))
                    }
                    LogoutButton()
                }
            } else {
                LoginView()
            }
        }
        .onReceive(store.credentials()) {
            credentials in self.credentials = credentials
        }
        .onReceive(store.currentUser()) { user in
            self.currentUser = user
        }
        .onReceive(store.timersForOrganizationID(orgID: selectedOrgId)) {timers in
            if self.displayedTimers != timers {
                self.displayedTimers = timers
            }
        }
        .onReceive(timerPublisher) { date in
            self.currentTime = date
        }
        .onAppear(perform: store.getTimers)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
