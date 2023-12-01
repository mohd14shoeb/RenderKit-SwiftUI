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
                    .offset(y:170)
                    .frame(width: r.size.width, alignment: .leading)
                    .foregroundColor(Color.white)
                }.background(Image("shot1", bundle: Bundle.module)
                    .resizable()
                    .padding(-10)
                    .frame(idealWidth: r.size.width, idealHeight:400).offset(y:60)
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
    
    init(name: String, description: String, size: String, itemColor: String, price: String, image: String) {
        self.name = name
        self.description = description
        self.size = size
        self.itemColor = itemColor
        self.price = price
        self.image = image
    }
}

@available(iOS 16.0, *)
struct SearchBarResults: View {
    @ObservedObject var data : SampleData
    @State var showItem: Bool = false
    var items: [Item] = [
        Item(name: "Gray Hoodie", description: "terry cloth fuzzy", size: "L", itemColor: "Gray", price: "30.00", image:"shot1"),
        Item(name: "Black Rocker T Shirt", description: "100% cotton", size: "L", itemColor: "Black", price: "30.00", image:"shot2"),
        Item(name: "Hoodie pull over", description: "terry cloth fuzzy", size: "M", itemColor: "Light Blue", price: "30.00", image:"shot3"),
        Item(name: "Peace Up T Shirt", description: "woman tshirt", size: "M", itemColor: "Black", price: "30.00", image:"shot4"),
    ]
    var body: some View {
        
        HStack {
            
            ForEach(items) { item in
             
                if (item.name.contains(data.searchText) || data.searchText == ""){
                    Image(item.image, bundle: Bundle.module).resizable()
                        .scaledToFit()
                        .frame(idealWidth:100, idealHeight:100)
                        .opacity(showItem ? 0.0 : 1.0)
                        .animation(Animation.easeInOut(duration: 2.5), value: showItem)
                }
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
                            .padding(10)
                            .foregroundColor(Color.white)
                        TextField("", text: $data.searchText, onCommit: {
                            
                        })
                        .frame(alignment:.top)
                        .onTapGesture(perform: {
                            data.searchText = ""
                        })
                        .foregroundColor(Color.white)
                    }
                    .frame(alignment:.top)
                    .background(Rectangle()
                        .stroke(Color.black, lineWidth: Config().borderWidth)
                        .cornerRadius(2)
                        .padding(2)
                    )
                    .background(Rectangle()
                        .fill(Color.white.opacity(0.1))
                        .cornerRadius(2)
                        .padding(2)
                    ).frame(alignment:.top)
                   
                  
                }
            }
        }
    }
}

@available(iOS 16.0, *)
struct SearchBarPreview: PreviewProvider {
 
    static var previews : some View {
       ViewThatFits {
            GeometryReader { r in
                VStack {
                    SearchBar(data: SampleData())
                .frame(idealWidth:r.size.width)
                }
   
            }
        }
    }
}


struct Config {
    let background = Color.yellow.opacity(0.1)
    let textColor = Color.blue
    let borderWidth = 1.0
    let boxCornerRadius = 2.0
}
