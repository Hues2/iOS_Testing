//
//  MatchedGeometryEffectTest.swift
//  TestingThings
//
//  Created by Greg Ross on 19/08/2022.
//

import SwiftUI

struct MatchedGeometryEffectTest: View {
    @State var isClicked: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack{
            if !isClicked{
            RoundedRectangle(cornerRadius: 25)
                .matchedGeometryEffect(id: "square", in: namespace)
                .frame(width: 100, height: 100)
                
            }
            
            Spacer()
            
            if isClicked{
            RoundedRectangle(cornerRadius: 25)
                .matchedGeometryEffect(id: "square", in: namespace)
                .frame(width: 300, height: 200)
                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1)){
                isClicked.toggle()
            }
        }
        
    }
}

struct MatchedGeometryEffectTest_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryEffectTest()
    }
}

