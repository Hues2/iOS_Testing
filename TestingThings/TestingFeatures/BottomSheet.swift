//
//  BottomSheet.swift
//  TestingThings
//
//  Created by Greg Ross on 16/08/2022.
//

import SwiftUI

struct BottomSheet: View {
    @State private var showingCredits = false
    
    var body: some View {
        Button("Show Credits") {
            showingCredits.toggle()
        }
        .sheet(isPresented: $showingCredits) {
            Text("This app was brought to you by Hacking with Swift")
            // FOR IOS 16
//                .presentationDetents([.medium, .large])
        }
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet()
    }
}
