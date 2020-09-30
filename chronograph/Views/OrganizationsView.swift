//
//  OrganizationView.swift
//  chronograph
//
//  Created by Govind krishna Joshi on 30/09/20.
//  Copyright © 2020 nilenso. All rights reserved.
//

import SwiftUI

struct OrganizationsView: View {
    @Environment(\.store) var store: Store;
        
    @State var organizations: [Organization] = [];
    
    var body: some View {
        return VStack {
            Text("Organizations")
            ForEach(organizations, id: \.id) { organization in
                Text(organization.name)
            }
        }.onReceive(store.organizations(), perform: { organizations in
            self.organizations = organizations
        }).onAppear(perform: store.getOrganizations)
    }
}
