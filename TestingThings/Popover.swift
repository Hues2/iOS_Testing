//
//  Popover.swift
//  TestingThings
//
//  Created by Greg Ross on 16/08/2022.
//

import SwiftUI

struct Popover: View {
    
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 20){
            Text("TESTING POPOVERS")
            Button {
                isPresented.toggle()
            } label: {
                HStack{
                    Text("Toggle Popover")
                    Image(systemName: "togglepower")
                }
                
            }
            

        }
        .popover(isPresented: $isPresented, attachmentAnchor: .point(.trailing), arrowEdge: .trailing) {
            VStack {
                        Text("Today is:")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                        
                        Text("hi")
                            .font(.title2)
                    }
                    .frame(width: 350, height: 200)
        }
        
    }
}

struct Popover_Previews: PreviewProvider {
    static var previews: some View {
        Popover()
    }
}
