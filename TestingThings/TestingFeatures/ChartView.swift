//
//  ChartView.swift
//  TestingThings
//
//  Created by Greg Ross on 01/11/2022.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    let listOfMachines: [Machine] = [
        Machine(machineName: "Macbook Pro", appBuildTime: 27),
        Machine(machineName: "Macbook Air", appBuildTime: 53),
        Machine(machineName: "Mac Mini", appBuildTime: 24.8),
        Machine(machineName: "Mac", appBuildTime: 35.8)
    ]
    
    var body: some View {
        
        VStack{
            Chart(listOfMachines){ machine in
                BarMark(x: .value("Machine", machine.machineName), y: .value("Build Time", machine.appBuildTime))
                    .foregroundStyle(LinearGradient(colors: [.blue, .teal], startPoint: .bottom, endPoint: .top))
            }
        }
        
        Spacer()
        
        Text("BAR CHART")
            .fontWeight(.black)
        
    }
}

struct Machine: Identifiable{
    let id: UUID = UUID()
    let machineName: String
    let appBuildTime: Double
}
