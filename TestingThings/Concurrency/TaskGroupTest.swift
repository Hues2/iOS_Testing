//
//  TaskGroupTest.swift
//  TestingThings
//
//  Created by Greg Ross on 20/08/2022.
//

import SwiftUI


class TaskGroupDataService{
    
    func fetchImagesWithAsyncLet() async throws -> [UIImage]{
        
        do {
            async let fetchImage1 = fetchImage(urlString: "https://picsum.photos/300")
            async let fetchImage2 = fetchImage(urlString: "https://picsum.photos/300")
            async let fetchImage3 = fetchImage(urlString: "https://picsum.photos/300")
            async let fetchImage4 = fetchImage(urlString: "https://picsum.photos/300")
            
            let (image1, image2, image3, image4) = try await ( fetchImage1,  fetchImage2,  fetchImage3,  fetchImage4)
            
            return [image1, image2, image3, image4]
            
        } catch {
            throw error
            print("\n One of the fetch images failed \n")
        }
        
    }
    
    
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        let urlStrings: [String] = ["https://picsum.photos/300", "https://picsum.photos/300", "https://picsum.photos/300", "https://picsum.photos/300", "https://picsum.photos/300", "https://picsum.photos/300"]
        
        return try await withThrowingTaskGroup(of: UIImage?.self) { taskGroup in
            var images: [UIImage] = []
            images.reserveCapacity(urlStrings.count)
            
            for urlString in urlStrings{
                taskGroup.addTask {
                    try? await self.fetchImage(urlString: urlString)
                }
            }
            
//            group.addTask {
//                try await self.fetchImage(urlString: "https://picsum.photos/300")
//            }
//            group.addTask {
//                try await self.fetchImage(urlString: "https://picsum.photos/300")
//            }
//            group.addTask {
//                try await self.fetchImage(urlString: "https://picsum.photos/300")
//            }
//            group.addTask {
//                try await self.fetchImage(urlString: "https://picsum.photos/300")
//            }
            
            
            for try await image in taskGroup{
                if let image = image  {
                    images.append(image)
                }
                
            }

            return images
        }
    }
    
    
    
    private func fetchImage(urlString: String) async throws -> UIImage{
        guard let url = URL(string: urlString) else {throw URLError(.badURL)}
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data){
                return image
            } else{
                throw URLError(.badServerResponse)
            }
        } catch {
            throw error
        }
        
    }
}



class TaskGroupTestViewModel: ObservableObject{
    
    @Published var images: [UIImage] = []
    
    private let dataService = TaskGroupDataService()
    
    func getImages() async {
        if let images = try? await dataService.fetchImagesWithTaskGroup(){
            self.images.append(contentsOf: images)
        }
    }
}



struct TaskGroupTest: View {
    @StateObject private var vm = TaskGroupTestViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let url = URL(string: "https://picsum.photos/300")!
        
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(vm.images, id:\.self){ image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(15)
                            .shadow(color: .blue, radius: 3, x: 0, y: 0)
                            .shadow(color: .blue, radius: 3, x: 0, y: 0)
                            .padding()
                        
                    }
                }
            }
            .navigationTitle("TASK GROUP 🥳")
            .task{
                await vm.getImages()
            }
    }
    }
}


