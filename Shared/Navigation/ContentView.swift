//
//  ContentView.swift
//  Shared
//
//  Created by Greg Hughes on 2/4/21.
//

import SwiftUI

struct ContentView: View {
//    @ViewBuilder
    var body: some View {
        #if os(iOS)
        Sidebar()
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
