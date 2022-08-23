//
//  MyCustomTabViewTest.swift
//  TestingThings
//
//  Created by Greg Ross on 23/08/2022.
//

import SwiftUI

struct MyCustomTabViewTest: View {
    @State var selection: MyTabItem = .favourites
    
    
    var body: some View {
        MyCustomTabView(selection: $selection) {
            Color.blue
                .myTabBarItem(tab: .home, selection: $selection)
            
            Color.red
                .myTabBarItem(tab: .favourites, selection: $selection)
            
            Color.green
                .myTabBarItem(tab: .profile, selection: $selection)
        }
    }
}

struct MyCustomTabViewTest_Previews: PreviewProvider {
    static var previews: some View {
        MyCustomTabViewTest()
    }
}
