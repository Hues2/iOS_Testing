//
//  MyTabItemView.swift
//  TestingThings
//
//  Created by Greg Ross on 23/08/2022.
//

import SwiftUI



struct MyTabItemView: View {
    
    let tab: MyTabItem
    let namespace: Namespace.ID
    @Binding var localSelection: MyTabItem
    
    var body: some View {
        VStack{
            Image(systemName: tab.iconName)
                .font(.headline)
            Text(tab.title)
                .font(.headline)
        }
        .foregroundColor(tab == localSelection ? tab.color : Color.gray)
        .padding(.horizontal, 30)
        .padding(.vertical, 5)
        .background(
            ZStack{
                if localSelection == tab{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
        
        
    }
}

struct MyTabItemView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabItemView(tab: .home, namespace: Namespace().wrappedValue, localSelection: .constant(.home))
    }
}
