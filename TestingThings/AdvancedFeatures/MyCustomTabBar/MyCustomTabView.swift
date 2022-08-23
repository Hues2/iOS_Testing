//
//  MyCustomTabView.swift
//  TestingThings
//
//  Created by Greg Ross on 23/08/2022.
//

import SwiftUI

struct MyCustomTabView<Content: View>: View {
    
    @Binding var selection: MyTabItem
    let content: Content
    @State private var tabs: [MyTabItem] = []
    
    
    init(selection: Binding<MyTabItem>, @ViewBuilder content: () -> Content){
        self.content = content()
        self._selection = selection
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack{
                content
            }
            .edgesIgnoringSafeArea([.top])
            
            
            MyCustomTabBar(tabs: tabs, selection: $selection, localSelection: selection)
                .padding(.top, 10)
        }
        .onPreferenceChange(MyCustomTabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}

//struct MyCustomTabView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        MyCustomTabView()
//    }
//}
