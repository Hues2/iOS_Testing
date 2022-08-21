//
//  ContinuationsTest.swift
//  TestingThings
//
//  Created by Greg Ross on 20/08/2022.
//

import SwiftUI


class ContinuationsNetworkManager{
    
    func getData(url: URL) async throws -> Data{
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            print("\n Coild not fetch the data from the url: \(url). More info: \(error.localizedDescription) \n")
            throw error
        }
    }
    
    
    
    /*
        This converts a function that is not async into an async one
        This instance uses a URLSession with data that is not async, so I wrap it in the
        withCheckedThrowingContinuation as this will make other code in the function await for the data
        that comes back from the urlsession call
     */
    func getData2(url: URL) async throws -> Data{
       return try await withCheckedThrowingContinuation { continuation in
           URLSession.shared.dataTask(with: url) { data, response, error in
               // Continuation HAS to be called
               // ONLY ONCE
               if let data = data{
                   continuation.resume(returning: data)
               } else if let error = error{
                   continuation.resume(throwing: error)
               } else{
                   continuation.resume(throwing: URLError(.badURL))
               }
           }
           .resume()
        }
    }
    
    
    func getHeartImageFromDatabaseCompletion(completionHandler: @escaping (_ image: UIImage) -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            completionHandler(UIImage(systemName: "heart.fill")!)
        }
    }
    
    func getHeartImageFromDatabase() async throws -> UIImage{
        do {
            return try await withCheckedThrowingContinuation({ continuation in
                getHeartImageFromDatabaseCompletion { image in
                    continuation.resume(returning: image)
                }
            })
        } catch {
            print("\n \(error.localizedDescription) \n")
            throw error
        }
        
        
        
    }
}



class ContinuationsTestViewModel: ObservableObject{
    
    @Published var image: UIImage? = nil
    
    private let networkManager = ContinuationsNetworkManager()

    
    func getImage() async {
        guard let url = URL(string: "https://picsum.photos/300") else {return}
        
        do {
            let data = try await networkManager.getData2(url: url)
            
            if let uiImage = UIImage(data: data){
                await MainActor.run {
                    self.image = uiImage
                }
            } else{
                throw URLError(.badURL)
            }
        } catch {
            print("\n Error getting data from network manager --> \(error.localizedDescription) \n")
        }
        
    }
    
    
//    func getHeartImage() {
//        networkManager.getHeartImageFromDatabase { [weak self] image in
//            self?.image = image
//        }
//    }
    
    func getHeartImage() async {
        
        do {
            let image = try await networkManager.getHeartImageFromDatabase()
            
            await MainActor.run {
                self.image = image
            }
        } catch {
            print("\n \(error.localizedDescription) \n")
        }
        
    }
    
    
}




struct ContinuationsTest: View {
    @StateObject var vm = ContinuationsTestViewModel()
    
    var body: some View {
        ZStack{
            if let image = vm.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
            }
        }
        .task {
//            await vm.getImage()
            await vm.getHeartImage()
        }
    }
}

struct ContinuationsTest_Previews: PreviewProvider {
    static var previews: some View {
        ContinuationsTest()
    }
}
