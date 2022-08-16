//
//  PopupModal.swift
//  TestingThings
//
//  Created by Greg Ross on 16/08/2022.
//

import SwiftUI

struct PopupModal: View {
    
    @State var showModal: Bool = false
    
    var body: some View {
        ZStack{
            Color.green
                .ignoresSafeArea()
            
            button

            
            modal
                .offset(y: showModal ? UIScreen.main.bounds.height / 2 : UIScreen.main.bounds.height)
            
        }
    }
}





extension PopupModal{
    private var modal: some View{
        VStack{
            HStack{
                Spacer()
                Image(systemName: "xmark")
                    .font(.title.bold())
                    .padding()
                    .onTapGesture {
                        withAnimation(.spring()){
                            showModal = false
                        }
                        
                    }
            }
            
            Text("Added to basket!")
                .font(.title)
            Spacer()
                
        }
        .frame(maxWidth: .infinity)
        .background(
            Color.white
        )
        .cornerRadius(30)
        .ignoresSafeArea(edges: [.bottom])
    }
    
    private var button: some View{
        Button {
            withAnimation(.spring()){
                showModal = true
            }
            
        } label: {
            HStack {
                Text("ADD TO BASKET")
                
                Image(systemName: "cart.fill")
            }
            .padding(7.5)
        }
        .font(.title3)
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .stroke(.white)
        )
    }
}



struct PopupModal_Previews: PreviewProvider {
    static var previews: some View {
        PopupModal()
    }
}
