//
//  MyCustomTabBarItemsPreferenceKey.swift
//  TestingThings
//
//  Created by Greg Ross on 23/08/2022.
//

import Foundation
import SwiftUI


struct MyCustomTabBarItemsPreferenceKey: PreferenceKey{
    
    static var defaultValue: [MyTabItem] = []
    
    static func reduce(value: inout [MyTabItem], nextValue: () -> [MyTabItem]) {
        value += nextValue()
    }
}


struct MyCustomTabViewModifier: ViewModifier{
    
    let tab: MyTabItem
    @Binding var selection: MyTabItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: MyCustomTabBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View{
    
    func myTabBarItem(tab: MyTabItem, selection: Binding<MyTabItem>) -> some View{
        modifier(MyCustomTabViewModifier(tab: tab, selection: selection))
    }
}
