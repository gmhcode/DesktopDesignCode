//
//  CourseDetail.swift
//  DesignCodeCourse
//
//  Created by Greg Hughes on 2/10/21.
//

import SwiftUI

struct CourseDetail: View {
    var course: Course = courses[0]
    var namespace: Namespace.ID
    
    #if os(iOS)
    var cornerRadius: CGFloat = 22
    #else
    var cornerRadius: CGFloat = 0
    #endif
    
    var body: some View {
        #if os(iOS)
        content
            .edgesIgnoringSafeArea(.all)
        #else
        content
        #endif
        
    }
    var content: some View {
        VStack {
            ScrollView {
                CourseItem(course: course, cornerRadius: 0)
                    .matchedGeometryEffect(id: course.id, in: namespace)
                    .frame(height: 300)
                VStack {
                    ForEach(courseSections) { item in
                        CourseRow(item: item)
                        Divider()
                    }
                }
                .padding()
            }
        }
        
        .background(Color("Background 1"))
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        .matchedGeometryEffect(id: "container\(course.id)", in: namespace)
        
        //                .transition(
        //                    .asymmetric(
        //                        insertion: AnyTransition
        //                            .opacity
        //                            .animation(Animation.spring().delay(0.5)),
        //                        removal: AnyTransition
        //                            .opacity
        //                            .animation(Animation.spring()))
        //                )
    }
}

struct CourseDetail_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CourseDetail(namespace: namespace)
    }
}
