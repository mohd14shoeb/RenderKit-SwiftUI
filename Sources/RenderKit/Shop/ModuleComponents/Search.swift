//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-11-30.
//

import Foundation
import SwiftUI


@available(iOS 16.0, *)
struct ImageScroll: View {
    var body: some View {
        ZStack {
            GeometryReader { r in
                ZStack {
                    VStack {
                        Text("Recommendations")
                            .font(.Small).opacity(0.5)
                            .frame(width: r.size.width, alignment: .leading)
                        Text("Womens Gray Hoodie")
                            .font(.Large)
                            .frame(width: r.size.width, alignment: .leading)
                        Text("$30")
                            .font(.XLarge)
                            .foregroundColor(Color.blue.opacity(0.4))
                            .frame(width: r.size.width, alignment: .leading)
                    }
                    .padding(10)
                    .offset(x:10, y:200)
                    .frame(width: r.size.width, alignment: .leading)
                    .foregroundColor(Color.white)
                }.background(Image("shot1", bundle: Bundle.module)
                    .resizable()
                    .padding(-10)
                    .frame(idealWidth: r.size.width, idealHeight:400).offset(y:90)
                    .scaledToFill())
            }
        }
    }
}

class Item: Identifiable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var size: String //enum
    var itemColor: String //enum
    var price: String
    var image: String
    var showItem: Bool
    
    init(name: String, description: String, size: String, itemColor: String, price: String, image: String, showItem: Bool) {
        self.name = name
        self.description = description
        self.size = size
        self.itemColor = itemColor
        self.price = price
        self.image = image
        self.showItem = showItem
    }
}

@available(iOS 16.0, *)
struct SearchBarResults: View {
    @ObservedObject var data : SampleData
   
   @State var showItem: Bool = false
    var body: some View {
        
        HStack {
            let items = data.shopItems
            ForEach(items) { item in
                if (item.name.contains(data.searchText) || data.searchText == "") {
                    Image(item.image, bundle: Bundle.module)
                        .resizable()
                        .scaledToFit()
                        .frame(idealWidth:100, idealHeight:100)
                        .opacity(showItem ? 1.0 : 0.0)
                        .offset(y: showItem ? 0.0 : -10)
                        .animation(Animation.easeIn(duration: 1.0), value: showItem)
                        .mask(RoundedRectangle(cornerRadius: 15))
                       
                }
            }
            .onAppear() {
                showItem = true
            }
            .onDisappear() {
                showItem = false
             }
        }
    }
    
   
}

@available(iOS 16.0, *)
struct SearchResults: View {
    @ObservedObject var data : SampleData
   
   @State var showItem: Bool = false
   @State var isPresenting: Bool = false
 
    
    var body: some View {
        VStack(alignment:.leading) {
            GeometryReader { r in
                VStack(alignment:.leading) {
                    let items = data.shopItems
                    ForEach(items) { item in
                        if (item.name.contains(data.searchText) || data.searchText == "") {
                            HStack {
                                Image(item.image, bundle: Bundle.module)
                                    .resizable()
                                    .scaledToFit()
                                  //  .frame(idealWidth:100, idealHeight:100)
                                    .opacity(showItem ? 1.0 : 0.0)
                                    .offset(y: showItem ? 0.0 : -10)
                                    .animation(Animation.easeIn(duration: 1.0), value: showItem)
                                    .mask(RoundedRectangle(cornerRadius: 15))
                                VStack(alignment: .leading) {
                                    Text("\(item.name)")
                                    Text("$\(item.price)")
                                    Text("\(item.description)")
                                    
                                }
                                
                            }.frame(width:r.size.width, alignment: .leading)
                                .padding(0)
                                .onTapGesture {
                                    isPresenting.toggle()
                                }
                        }
                    }
                    .frame(width:r.size.width)
                    .padding(.leading, 10)
                    .onAppear() {
                        showItem = true
                    }
                    .onDisappear() {
                        showItem = false
                    }
                }.frame(width: r.size.width, height:300, alignment: .top)
            }.fullScreenCover(isPresented: $isPresenting,
                                                      onDismiss: {}) {
                                               VStack {
                                                 Text("A full-screen modal view.")
                                                     .font(.title)
                                                   Text("Tap to Dismiss")
                                               }
                                            .onTapGesture {
                                        isPresenting.toggle()
                                               }
                                 //              .foregroundColor(.white)
                                            .frame(maxWidth: .infinity,
                                           maxHeight: .infinity)
                                            .background(Color.blue)
                                  .ignoresSafeArea(edges: .all)
                                          }
        }
    }
    
   
}

@available(iOS 16.0, *)
struct SearchBar: View {
    @ObservedObject var data : SampleData
    var body: some View {
        VStack {
            GeometryReader { r in
                ZStack {
                    ImageScroll()
                }
                ZStack {
                    HStack {
                        Image(systemName: "magnifyingglass.circle")
                            .padding(20)
                            .foregroundColor(Color.white)
                        TextField("", text: $data.searchText, onCommit: {
                            
                        })
                       
                        .onTapGesture(perform: {
                            data.searchText = ""
                        })
                        .foregroundColor(Color.white)
                    }
               
                    .background(Config().buttonShape
                        .stroke(Color.black.opacity(0.4), lineWidth: Config().borderWidth)
                        .padding(10)
                    )
                    .background(Config().buttonShape
                        .fill(Color.white.opacity(0.1))
                        .padding(10)
                    ).frame(alignment:.top)
                   
                  
                }.padding(10)
            } .offset(y:20)
        }
    }
}

@available(iOS 16.0, *)
struct SearchBarPreview: PreviewProvider {
    static var data: SampleData = SampleData()
    static var previews : some View {
       ViewThatFits {
            GeometryReader { r in
                VStack {
                    SearchBar(data: data)
                    //SearchBarResults(data: data)
                    SearchResults(data: data)
                .frame(idealWidth:r.size.width)
                }
   
            }
        }
    }
}


