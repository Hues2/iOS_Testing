//
//  ModalViewModifier.swift
//  TestingThings
//
//  Created by Greg Ross on 16/08/2022.
//

import SwiftUI



// MARK: Modal Test View
struct ModalModifierTestView: View{
    @State var offsetAmount: Double = 2.0
    @State var showModal: Bool = false
    let item: String = "Football Goal"
    
    var body: some View{
        ZStack{
            Color.green
                .ignoresSafeArea()
            button
        }
        .modifier(ModalViewModifier(offsetAmount: $offsetAmount ,showModal: $showModal, item: item))
        
    }
}


extension ModalModifierTestView{
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




// MARK: Modal Modifier
struct ModalViewModifier: ViewModifier {
    @Binding var offsetAmount: Double
    @Binding var showModal: Bool
    let item: String
    
    
    
    func body(content: Content) -> some View {
        ZStack{
            content
            modal
            
        }
    }
}

extension ModalViewModifier{
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
            
            Text("Added \(item) to your basket!")
                .font(.title)
            Spacer()
                
        }
        .foregroundColor(.text)
        .frame(maxWidth: .infinity)
        .background(
            Color.background
        )
        .cornerRadius(30)
        .ignoresSafeArea(edges: [.bottom])
        .offset(y: showModal ? UIScreen.main.bounds.height / offsetAmount : UIScreen.main.bounds.height)
    }
}

//struct ModalViewModifier_Previews: PreviewProvider {
//    static var previews: some View {
//        ModalViewModifier()
//    }
//}
