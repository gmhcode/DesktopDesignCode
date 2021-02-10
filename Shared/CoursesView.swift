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
    @State var selectedItem: Course? = nil
    @State var isDisabled = false
    
    var body: some View {
        ZStack {
            ScrollView {
                //adaptive layout fits as many cards as possible with a min width of 160
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 160), spacing: 16)],
                    spacing: 16) {
                    ForEach(courses) { item in
                        VStack {
                            CourseItem(course: item)
                                .matchedGeometryEffect(id: item.id, in: namespace, isSource: !show)
                                .frame(height: 200)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0)) {
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
            }
            //keeps the content aboce the other cards
            .zIndex(1)
            //            .edgesIgnoringSafeArea(.all)
            if selectedItem != nil {
                ZStack(alignment: .topTrailing) {
                    VStack {
                        ScrollView {
                            CourseItem(course: selectedItem!)
                                .matchedGeometryEffect(id: selectedItem!.id, in: namespace)
                                .frame(height: 300)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        show.toggle()
                                        selectedItem = nil
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            isDisabled = false
                                        }
                                    }
                                }
                            VStack {
                                ForEach(0 ..< 20) { item in
                                    CourseRow()
                                }
                                
                            }
                            .padding()
                        }
                    }
                    
                    .background(Color("Background 1"))
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .matchedGeometryEffect(id: "container\(selectedItem!.id)", in: namespace)
                    //                .transition(
                    //                    .asymmetric(
                    //                        insertion: AnyTransition
                    //                            .opacity
                    //                            .animation(Animation.spring().delay(0.5)),
                    //                        removal: AnyTransition
                    //                            .opacity
                    //                            .animation(Animation.spring()))
                    //                )
                    
                    .edgesIgnoringSafeArea(.all)
                    CloseButton()
                        .padding(.trailing, 16)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                show.toggle()
                                selectedItem = nil
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    isDisabled = false
                                }
                            }
                        }
                }
                .zIndex(2)
            }
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
