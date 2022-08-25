//
//  UnitTestView.swift
//  TestingThings
//
//  Created by Greg Ross on 24/08/2022.
//


import SwiftUI


struct UnitTestView: View {
    @StateObject var vm: UnitTestingViewModel
    
    init(isPremium: Bool){
        _vm = StateObject(wrappedValue: UnitTestingViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

struct UnitTestView_Previews: PreviewProvider {
    static var previews: some View {
        UnitTestView(isPremium: true)
    }
}
