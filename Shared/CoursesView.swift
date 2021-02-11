//
//  CoursesView.swift
//  DesignCodeCourse
//
//  Created by Greg Hughes on 2/4/21.
//

import SwiftUI

struct CoursesView: View {
    @State var show = false
    //namespace is where you put the collection of matched elements
    @Namespace var namespace
    @Namespace var namespace2
    @State var selectedItem: Course? = nil
    @State var isDisabled = false
    #if os(iOS)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    #else
    #endif
    
    
    
    var body: some View {
        ZStack {
            #if os(iOS)
            if horizontalSizeClass == .compact {
                tabBar
            } else {
                sideBar
            }
            
            fullContent
                .background(VisualEffectBlur(blurStyle: .systemUltraThinMaterial).edgesIgnoringSafeArea(.all))
            #else
            content
            fullContent
                .background(VisualEffectBlur().edgesIgnoringSafeArea(.all))
            #endif
        }
        .navigationTitle(Text("Courses"))
    }
    
    var content: some View {
        ScrollView {
            
            VStack(spacing: 0) {
                
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 160), spacing: 16)],
                    spacing: 16) {
                    ForEach(courses) { item in
                        VStack {
                            CourseItem(course: item)
                                .matchedGeometryEffect(id: item.id, in: namespace, isSource: !show)
                                .frame(height: 200)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)) {
                                        show.toggle()
                                        selectedItem = item
                                        isDisabled = true
                                    }
                                }
                                .disabled(isDisabled)
                        }
                        .matchedGeometryEffect(id: "container\(item.id)", in: namespace, isSource: !show)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                Text("Latest Sections")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                LazyVGrid(columns: [GridItem(.adaptive(minimum:240))]) {
                    ForEach(courseSections) { item in
                        #if os(iOS)
                        NavigationLink(
                            destination: CourseDetail(namespace: namespace2))
                        {
                            CourseRow(item: item)
                        }
                        #else
                        CourseRow(item: item)
                        #endif
                        
                    }
                }
                .padding()
            }
            //adaptive layout fits as many cards as possible with a min width of 160
            
        }
        //keeps the content aboce the other cards
        .zIndex(1)
        .navigationTitle("Courses")
        //            .edgesIgnoringSafeArea(.all)
    }
    @ViewBuilder
    var fullContent: some View {
        if selectedItem != nil {
            ZStack(alignment: .topTrailing) {
                CourseDetail(course: selectedItem!, namespace: namespace)
                CloseButton()
                    .padding(16)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            show.toggle()
                            selectedItem = nil
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                isDisabled = false
                            }
                        }
                    }
            }
            .zIndex(2)
            .frame(maxWidth: 712)
            .frame(maxWidth:.infinity)
            
        }
    }
    //    @ViewBuilder
    var tabBar: some View {
        TabView {
            NavigationView{
                content
            }
            .tabItem {
                Image(systemName: "book.closed")
                Text("Courses")
            }
            NavigationView{
                CourseList()
            }
            .tabItem {
                Image(systemName: "list.bullet.rectangle")
                Text("Tutorials")
            }
            NavigationView{
                CoursesView()
            }
            .tabItem {
                Image(systemName: "tv")
                Text("Livestreams")
            }
            NavigationView{
                CourseList()
            }
            .tabItem {
                Image(systemName: "mail.stack")
                Text("Certificate")
            }
            NavigationView{
                CourseList()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
    }
     @ViewBuilder
    var sideBar: some View {
        #if os(iOS)
        NavigationView {
            List {
                NavigationLink(destination: CoursesView()) {
                    Label("Courses", systemImage: "book.closed")
                }
                Label("Tutorials", systemImage: "list.bullet.rectangle")
                Label("Livestreams", systemImage: "tv")
                Label("Certificates", systemImage: "mail.stack")
                Label("Search", systemImage: "magnifyingglass")
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Learn")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "person.crop.circle")
                }
            }
            content
        }
        #endif
        
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
