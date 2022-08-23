//
//  MyCustomTabBar.swift
//  TestingThings
//
//  Created by Greg Ross on 23/08/2022.
//

import SwiftUI


struct MyCustomTabBar: View {
    
    let tabs: [MyTabItem]
    @Binding var selection: MyTabItem
    @State var localSelection: MyTabItem
    
    
    @Namespace private var namespace
    
    var body: some View {
        HStack(){
            ForEach(tabs, id:\.self){ tab in
                MyTabItemView(tab: tab, namespace: namespace, localSelection: $localSelection)
                    .onTapGesture {
                        selection = tab
                        withAnimation(.easeInOut){
                            localSelection = tab
                        }
                    }
            }
        }
    }
}

struct MyCustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MyCustomTabBar(tabs: [.home, .favourites, .profile], selection: .constant(.home), localSelection: .home)
    }
}
