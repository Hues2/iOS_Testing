//
//  CacheTest.swift
//  TestingThings
//
//  Created by Greg Ross on 17/08/2022.
//

import SwiftUI



class CacheManager{
    static let instance = CacheManager()
    
    private init(){}
    
    // Maybe use NSCache<NSString, Data>
    // This way I can make a method called getImageData, that either gets the data
    // from the cache or gets it from the internet
    // that data can then be used for UIImage(data: Data)
    var imageCache: NSCache<NSString, UIImage> = {
       let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
        return cache
    }()
    
    
    func add(image: UIImage, name: String){
        imageCache.setObject(image, forKey: name as NSString)
        print("\n Added to cache \n")
    }
    
    func remove(name: String){
        imageCache.removeObject(forKey: name as NSString)
        print("\n Removed from cache \n")
    }
    
    
    func get(name: String) -> UIImage?{
        return imageCache.object(forKey: name as NSString)
        print("\n Got image from cache \n")
    }
    
}


class CacheViewModel: ObservableObject{
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedimage: UIImage? = nil
    let imageName = "cheetah"
    let manager = CacheManager.instance
    
    
    init(){
        getImageFromAssetsFolder()
    }
    
    
    func getImageFromAssetsFolder(){
        // Get from cache
        if let image = manager.get(name: imageName){
            startingImage = image
            print("\n Image showing is from cache \n")
        }
        // If not, "download" from API
        else{
            startingImage = UIImage(named: imageName)
            print("\n Image is from 'API' \n")
        }
        
    }
    
    func saveToCache(){
        guard let image = startingImage else {
            return
        }
        
        manager.add(image: image, name: imageName)
    }
    
    func removeFromCache(){
        manager.remove(name: imageName)
    }
    
    func getFromCache(){
        cachedimage = manager.get(name: imageName)
    }
    
}



struct CacheTest: View {
    
    @StateObject var vm = CacheViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                if let image = vm.startingImage{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
              
                
                HStack {
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("Save to cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                }
                    Button {
                        vm.removeFromCache()
                    } label: {
                        Text("Delete from cache")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                    }

                }
                
                Button {
                    vm.getFromCache()
                } label: {
                    Text("Get from cache")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .cornerRadius(10)
                }
                
                
                if let image = vm.cachedimage{
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }

            }
            .navigationTitle(Text("Cache Test"))
        }
    }
}

struct CacheTest_Previews: PreviewProvider {
    static var previews: some View {
        CacheTest()
    }
}
