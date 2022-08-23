//
//  CustomTabBarView.swift
//  TestingThings
//
//  Created by Greg Ross on 22/08/2022.
//

import SwiftUI

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    @State var localSelection: TabBarItem
    
    
    var body: some View {
        tabBarVersion2
            .onChange(of: selection) { newValue in
                withAnimation(.easeInOut){
                    localSelection = newValue
                }
            }
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [.home, .favourites, .profile]
    static var previews: some View {
        VStack{
            Spacer()
            CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
        }
        
    }
}



extension CustomTabBarView{
    
    private func tabView(tab: TabBarItem) -> some View{
        VStack{
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tab ? tab.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(localSelection == tab ? tab.color.opacity(0.2) : .clear)
        .cornerRadius(10)
        
    }
    
    
    private var tabBarVersion1: some View{
        HStack{
            ForEach(tabs, id:\.self){ tab in
                tabView(tab: tab)
                    .onTapGesture {
//                        switchToTab(tab: tab)
                        selection = tab
                    }
            }
        }
        .padding(6)
        .background(
            Color.white
                .edgesIgnoringSafeArea([.bottom])
        )
    }
    
    
    
    
    private func switchToTab(tab: TabBarItem){
        // This makes the content animate along with the tab bar animation
//        withAnimation(.easeInOut){
            selection = tab
//        }
    }
    
}



extension CustomTabBarView{
    
    private func tabView2(tab: TabBarItem) -> some View{
        VStack{
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tab ? tab.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack{
                
                if localSelection == tab{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
        
    }
    
    
    
    private var tabBarVersion2: some View{
        HStack{
            ForEach(tabs, id:\.self){ tab in
                tabView2(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(
            Color.white
                .edgesIgnoringSafeArea([.bottom])
        )
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
    
}
