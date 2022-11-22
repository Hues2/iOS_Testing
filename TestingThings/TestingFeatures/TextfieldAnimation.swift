//
//  TextfieldAnimation.swift
//  TestingThings
//
//  Created by Greg Ross on 04/11/2022.
//

import SwiftUI
import Combine


class TextfieldAnimationVM: ObservableObject{
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var usernameIsValid: Bool = false
    @Published var passwordIsValid: Bool = false
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    
    func addSubscribers(){
        $username
            .sink { [weak self] returnedString in
                if returnedString.count > 3{
                    withAnimation {
                        self?.usernameIsValid = true
                    }
                    
                } else {
                    withAnimation {
                        self?.usernameIsValid = false
                    }
                }
            }
            .store(in: &cancellables)
        
        
        $password
            .sink { [weak self] returnedString in
                if returnedString.count > 3{
                    withAnimation {
                        self?.passwordIsValid = true
                    }
                    
                } else {
                    withAnimation {
                        self?.passwordIsValid = false
                    }
                }
            }
            .store(in: &cancellables)
    }
    
}








struct TextfieldAnimation: View {
    
    private enum Field: Int, CaseIterable{
        case username, password
    }
    
    @StateObject private var vm = TextfieldAnimationVM()
    
    @FocusState private var focusField: Field?
    @Namespace private var namespace
        
    var body: some View {
        
        VStack{
            Spacer()
            
            ZStack(alignment: .bottomLeading){
                ZStack(alignment: .trailing){
                    // MARK: Username
                    TextField("Username", text: $vm.username)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.clear)
                        }
                        .padding(.horizontal)
                        .focused($focusField, equals: .username)
                    
                    if vm.usernameIsValid{
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .padding(.horizontal)
                            .matchedGeometryEffect(id: "username", in: namespace)
                    }
                }
                
                if !vm.usernameIsValid{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.green)
                        .frame(height: 2)
                        .frame(maxWidth: focusField == .username ? .infinity : 0)
                        .padding(.horizontal)
                        .animation(.spring(), value: focusField)
                        .matchedGeometryEffect(id: "username", in: namespace)
                }
            }
            
            
            // MARK: Password
            ZStack(alignment: .bottomLeading){
                ZStack(alignment: .trailing){
                    // MARK: Username
                    TextField("Password", text: $vm.password)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.clear)
                        }
                        .padding(.horizontal)
                        .focused($focusField, equals: .password)
                    
                    if vm.passwordIsValid{
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .padding(.horizontal)
                            .matchedGeometryEffect(id: "password", in: namespace)
                    }
                }
                
                if !vm.passwordIsValid{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.green)
                        .frame(height: 2)
                        .frame(maxWidth: focusField == .password ? .infinity : 0)
                        .padding(.horizontal)
                        .animation(.spring(), value: focusField)
                        .matchedGeometryEffect(id: "password", in: namespace)
                }
            }

            
            Spacer()
        }
        .contentShape(Rectangle())
        .gesture(
            DragGesture()
                .onEnded({ value in
                    if value.translation.height > 100{
                        withAnimation(.spring()) {
                            focusField = nil
                        }
                    }
                })
        )

        

        
    }
}

struct TextfieldAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TextfieldAnimation()
    }
}
