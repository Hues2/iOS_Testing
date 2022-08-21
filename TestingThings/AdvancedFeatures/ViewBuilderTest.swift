//
//  ViewBuilderTest.swift
//  TestingThings
//
//  Created by Greg Ross on 21/08/2022.
//

import SwiftUI


struct HeaderViewRegular: View{
    
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View{
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            if let description = description {
                Text(description)
                    .font(.callout)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
            }
              
            if let iconName = iconName {
                Image(systemName: iconName)
            }
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)

            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}


struct HeaderViewGeneric<Content: View>: View{
   
    let title: String
    let content: Content
    
    
    // Using the view builder here lets us pass in a view via a closure
    init(title: String, @ViewBuilder content: () -> Content){
        self.title = title
        self.content = content()
    }
    
    var body: some View{
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)

            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)

            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}



// This works exactly like a normal HSTACK
struct CustomHStack<Content: View> : View{
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content){
        self.content = content()
    }
    
    var body: some View{
        HStack{
            content
        }
    }
}


struct ViewBuilderTest: View {
    
    var body: some View {
        VStack{
            HeaderViewRegular(title: "Title", description: "Description", iconName: "heart.fill")
            
            HeaderViewRegular(title: "Another Title", description: nil, iconName: nil)
            
//            HeaderViewGeneric(title: "Generic Title", content: Text("Content"))
//
//            HeaderViewGeneric(title: "Generic Title", content: Image(systemName: "heart.fill"))
//
//            HeaderViewGeneric(title: "Generic Title", content: HeaderViewRegular(title: "hi", description: "hi2", iconName: nil))
            
            HeaderViewGeneric(title: "Hi Title") {
                testBody
            }
            
            
            CustomHStack {
                Text("Hi")
                Text("Hi")
                Text("Hi")
                Text("Hi")
            }

            
            Spacer()
            
        }
    }
    
    private var testBody: some View{
        HStack{
            Text("Hi")
        }
    }
}

struct ViewBuilderTest_Previews: PreviewProvider {
    static var previews: some View {
//        ViewBuilderTest()
        LocalViewBuilder(type: .two)
    }
}



struct LocalViewBuilder: View{
    
    enum ViewType{
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View{
        VStack{
            headerSection
        }
    }
    
    @ViewBuilder private var headerSection: some View{
        switch type {
        case .one:
            viewOne
        case .two:
            viewTwo
        case .three:
            viewThree
        }
    }
    
    private var viewOne: some View{
        Text("One")
    }
    
    private var viewTwo: some View{
        VStack{
            Text("two")
            Image(systemName: "heart.fill")
        }
    }
    
    private var viewThree: some View{
        Image(systemName: "heart.fill")
    }
}
