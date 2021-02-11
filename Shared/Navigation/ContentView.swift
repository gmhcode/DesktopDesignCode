//
//  ContentView.swift
//  Shared
//
//  Created by Greg Hughes on 2/4/21.
//

import SwiftUI

struct ContentView: View {
//    @ViewBuilder
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #endif
    var body: some View {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            //Tabbar
            CoursesView()
        }else {
            CoursesView()
        }
        #else
        Sidebar()
            .frame(minWidth: 1000, minHeight: 600)
        #endif
     
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
