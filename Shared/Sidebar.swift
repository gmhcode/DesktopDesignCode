//
//  Sidebar.swift
//  DesignCodeCourse
//
//  Created by Greg Hughes on 2/4/21.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        NavigationView {
            List {
                Label("Courses", systemImage: "book.closed")
                Label("Tutorials", systemImage: "list.bullet.rectangle")
                Label("LiveStreams", systemImage: "tv")
                Label("Certificates", systemImage: "mail.stack")
                Label("Search", systemImage: "magnifyingglass")
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Learn")
        }
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
