//
//  OrganizationSelect.swift
//  chronograph
//
//  Created by Sandilya Jandhyala on 16/11/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import SwiftUI

struct OrganizationSelect: View {
    @Environment(\.store) var store: Store
    @State var organizations: [Organization] = []
    var orgIDSelection: Binding<Int>
    	
    public init(orgIDSelection: Binding<Int>) {
        self.orgIDSelection = orgIDSelection
    }
    
    var body: some View {
        VStack {
            if organizations.count > 0 {
                Picker("Choose an organization", selection: orgIDSelection) {
                    ForEach(organizations, id: \.id) { organization in
                        Text(organization.name).tag(organization.id)
                    }
                }
            } else {
                Text("Loading org select")
            }
        }.onReceive(store.organizations(), perform: { organizations in
            if self.organizations.count == 0 && organizations.count > 0 {
                self.orgIDSelection.wrappedValue = organizations[0].id
            }
            self.organizations = organizations
        }).onAppear(perform: store.getOrganizations)
    }
}
