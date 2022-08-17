//
//  BBCNewsView.swift
//  TestingThings
//
//  Created by Greg Ross on 15/08/2022.
//

import SwiftUI

struct BBCNewsView: View {
    @Namespace var nameSpace
    
    let topics = [Topic(id: 0, name: "Sport"),
                  Topic(id: 1, name: "Technology"),
                  Topic(id: 2, name: "Education"),
                  Topic(id: 3, name: "Politics"),
                  Topic(id: 4, name: "Politics"),
                  Topic(id: 5, name: "UK"),
                  Topic(id: 6, name: "For You"),
                  Topic(id: 7, name: "Regional"),
                  Topic(id: 8, name: "Apple"),
                  Topic(id: 9, name: "Jobs")]
    
    let listItems = [ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
                     ListItem(),
    ]
    
    @State var selectedId: Int = 0
    
    var body: some View {
        ZStack{
            // Color of navigation
            Color("bbcRed")
                .edgesIgnoringSafeArea([.top])
            
            // Background color for list and other content
            Color.black
            
            VStack(spacing: 0) {
                    
                sideTopicsScroll
                
                Spacer()
                
                TabView(selection: $selectedId){
                    ForEach(topics){ topic in
                        newsItemsList
                            .tag(topic.id)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                
            }
        }
        .animation(.spring(), value: selectedId)
        
            
    }
}

struct BBCNewsView_Previews: PreviewProvider {
    static var previews: some View {
        BBCNewsView()
            .preferredColorScheme(.dark)
    }
}






extension BBCNewsView{
    
    
    private var sideTopicsScroll: some View{
        ZStack{
            Color.black
            Color.bbcGray
            
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader{ proxy in
                    
                HStack(spacing: 20){
                    ForEach(topics){ topic in
                    
                        VStack{
                            Text(topic.name)
                                .fontWeight(.light)
                                .id(selectedId)
                                .padding(.leading, 3)
                                .onTapGesture {
                                    withAnimation(.spring()){
                                        selectedId = topic.id
                                    }
                                }
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.clear)
                                    .frame(width: 75, height: 3)
                                if topic.id == selectedId{
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(.white)
                                            .matchedGeometryEffect(id: "underline", in: nameSpace, properties: .frame)
                                    
                                    
                                }
                                
                            }
                        }
                        
                            
                    }//ForEach
                }
                .font(.headline)
                .padding()
                .onChange(of: selectedId) { newValue in
                    print("Changed")
                    withAnimation(.spring()){
                        proxy.scrollTo(selectedId, anchor: .center)
                    }
                    
                }
                
                
            }
            }//ScrollViewReader
        }//ScrollView
        .frame(height: 50)
    }
    
    
    private var newsItemsList: some View{
        List{
            ForEach(listItems){ item in
                item
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical, 5)
            }
        }
        .listStyle(.plain)
    }
}

struct ListItem: View, Identifiable{
    let id = UUID()

    
    var body: some View{
        HStack(alignment: .top) {
            Rectangle()
                .fill(Color.bbcRed.opacity(0.75))
                .frame(width: 150, height: 100)
            VStack(alignment: .leading, spacing: 5) {
                Text("This is some test text for the list item.")
                
                Spacer()
                
                HStack(alignment: .center, spacing: 3) {
                    Text("6d")
                    Text("|")
                    Text("Technology")
                }
            }
        }
    }
}


struct Topic: Identifiable{
    let id: Int
    let name: String
}

