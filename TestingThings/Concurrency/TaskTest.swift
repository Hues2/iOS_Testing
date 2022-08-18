//
//  TaskTest.swift
//  TestingThings
//
//  Created by Greg Ross on 18/08/2022.
//

import SwiftUI



class TaskTestViewModel: ObservableObject{
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    
    
    func fetchImage() async {
        try? await Task.sleep(nanoseconds: 5_000_000_000)
        
        do {
            
            guard let url = URL(string: "https://picsum.photos/200") else {return}
            
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Inside long tasks I may need to check if it has been cancelled with:
            try? Task.checkCancellation()
            
            await MainActor.run {
                self.image = UIImage(data: data)
                print("\n FETCHED IMAGE SUCCESSFULLY \n")
            }
            
            
        } catch {
            print("\n \(error.localizedDescription) \n")
        }
    }
    
    
    func fetchImage2() async {
        do {
            
            guard let url = URL(string: "https://picsum.photos/200") else {return}
            
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run {
                self.image2 = UIImage(data: data)
            }
            
        } catch {
            print("\n \(error.localizedDescription) \n")
        }
    }
    
}




struct TaskView: View{
    var body: some View{
        NavigationView{
            ZStack{
                NavigationLink("Click Me! 😜"){
                    TaskTest()
                }
            }
        }
    }
}


struct TaskTest: View {
    @StateObject var viewModel = TaskTestViewModel()
    
    @State private var fetchImageTask: Task<(), Never>? = nil
    
    var body: some View {
        VStack{
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            if let image = viewModel.image2{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .task {
            await viewModel.fetchImage()
        }
        
//        .onDisappear{
//            fetchImageTask?.cancel()
//        }
//        .onAppear{
//            self.fetchImageTask = Task{
//                await viewModel.fetchImage()
//            }
//            Task{
//                print("\n \(Thread.current) \n")
//                print("\n \(Task.currentPriority) \n")
//                await viewModel.fetchImage2()
//            }
            
            
//            Task(priority: .high) {
//                await Task.yield()
//                print("\n HIGH: \(Thread.current) : \(Task.currentPriority) \n")
//            }
//            Task(priority: .userInitiated) {
//                print("\n USER INITIATED: \(Thread.current) : \(Task.currentPriority) \n")
//            }
//            Task(priority: .medium) {
//                print("\n MEDIUM: \(Thread.current) : \(Task.currentPriority) \n")
//            }
//            Task(priority: .low) {
//                print("\n LOW: \(Thread.current) : \(Task.currentPriority) \n")
//            }
//            Task(priority: .utility) {
//                print("\n UTILITY: \(Thread.current) : \(Task.currentPriority) \n")
//            }
//            Task(priority: .background) {
//                print("\n BACKGROUND: \(Thread.current) : \(Task.currentPriority) \n")
//            }
//        }
    }
}




struct TaskTest_Previews: PreviewProvider {
    static var previews: some View {
        TaskTest()
    }
}
