//
//  ContentView.swift
//  Shared
//
//  Created by Greg Hughes on 2/4/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Spacer()
            HStack {
                HStack {
                    Spacer()
                    Image("Illustration 1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: nil)
                }
                Spacer()
            }
            Text("SwiftUI For iOS 14")
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                
            Text("20 Sections")
                .font(.footnote)
                .foregroundColor(Color.white)
                
                
        }
        .padding(.all)
        .background(Color.blue)
        .cornerRadius(20.0)
        .shadow(radius: 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/200.0/*@END_MENU_TOKEN@*/))
                .preferredColorScheme(.dark)
        }
    }
}
