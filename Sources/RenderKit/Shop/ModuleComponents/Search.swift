//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-11-30.
//

import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct SearchBar: View {
 
   
    @ObservedObject var data : SampleData
    var body: some View {
        VStack {
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
                            .foregroundColor(Color.blue.opacity(0.9))
                            .frame(width: r.size.width, alignment: .leading)
                    }
                    .padding(10)
                    .offset(y:170)
                    .frame(width: r.size.width, alignment: .leading)
                    .foregroundColor(Color.white)
                }.background(Image("shot1", bundle: Bundle.module)
                    .resizable()
                    .frame(width:r.size.width + 30, height:400).offset(y:60)
                    .scaledToFill())
                HStack {
                    Image(systemName: "magnifyingglass.circle")
                        .padding(10)
                        .foregroundColor(Color.white)
                    TextField("", text: $data.searchText, onCommit: {
                        
                    }).onTapGesture(perform: {
                        data.searchText = ""
                    })
                    .foregroundColor(Color.white)
                }.background(Rectangle()
                    .stroke(Color.black, lineWidth: Config().borderWidth)
                    .cornerRadius(2)
                    .padding(2)
                )
                .background(Rectangle()
                    .fill(Color.white.opacity(0.1))
                    .cornerRadius(2)
                    .padding(2)
                )
         
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
