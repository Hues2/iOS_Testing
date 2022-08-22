//
//  CustomTabBarContainerView.swift
//  TestingThings
//
//  Created by Greg Ross on 22/08/2022.
//

import SwiftUI

// THIS IS THE APPLE INIT FOR THE TAB VIEW
//struct TabView2<SelectionValue, Content> : View where SelectionValue : Hashable, Content : View {
//
//}
//struct TabView3<SelectionValue: Hashable, Content: View> : View{
//
//}


// My Tabview is going to use a TabViewItem as the selection
struct CustomTabBarContainerView<Content: View>: View {
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content){
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            content
                .ignoresSafeArea()
            
            CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
        
        
//        VStack(spacing: 0){
//            ZStack{
//                content
//            }
//
//            CustomTabBarView(tabs: tabs, selection: $selection)
//                .padding(.vertical, 10)
//        }
//        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
//            self.tabs = value
//        }
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .home, .favourites, .profile
    ]
    static var previews: some View {
        CustomTabBarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}
