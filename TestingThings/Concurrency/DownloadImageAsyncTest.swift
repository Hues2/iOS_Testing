//
//  DownloadImageAsyncTest.swift
//  TestingThings
//
//  Created by Greg Ross on 18/08/2022.
//

import SwiftUI
import Combine




class DownloadImageAsyncImageLoader{
    
    let url = URL(string: "https://picsum.photos/200")!
    
    
    // MARK: Common functionality for all methods of downloading
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage?{
        guard let data = data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else {
            return nil
        }
        return image
    }
    
    
    
    // MARK: Using Completion Handlers
    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()){
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let image = self?.handleResponse(data: data, response: response)
            
            completionHandler(image, error)

        }
        .resume()
    }
    
    // MARK: Using Combine
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error>{
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({$0})
            .eraseToAnyPublisher()
    }
    
    
    
    // MARK: Using Async Await
    func downloadWithAsync() async throws -> UIImage?{
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return handleResponse(data: data, response: response)
        } catch {
            throw error
        }
        
        
    }
    
}


class DownloadImageAsyncViewModel: ObservableObject{
    @Published var image: UIImage? = nil
    
    let loader = DownloadImageAsyncImageLoader()
    
    var cancellables = Set<AnyCancellable>()
    
    
    
    func fetchImage() async {
        
        // MARK: Using Completion
//        loader.downloadWithEscaping { [weak self] image, error in
//            DispatchQueue.main.async {
//                self?.image = image
//            }
//        }
        
        
        
        // MARK: Using Combine
//        loader.downloadWithCombine()
//            .receive(on: DispatchQueue.main)
//            .sink { _ in
//
//            } receiveValue: { [weak self] returnedImage in
//                self?.image = returnedImage
//            }
//            .store(in: &cancellables)
        
        
        // MARK: Using Async Await
        let image = try? await loader.downloadWithAsync()
        await MainActor.run {
            self.image = image
        }

    }
    
    
    
}


struct DownloadImageAsyncTest: View {
    
    @StateObject var viewModel = DownloadImageAsyncViewModel()
    
    var body: some View {
        ZStack{
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .onAppear{
            Task {
                await viewModel.fetchImage()
            }
        }
    }
}

struct DownloadImageAsyncTest_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageAsyncTest()
    }
}