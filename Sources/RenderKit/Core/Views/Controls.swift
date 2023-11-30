//
//  File.swift
//  
//
//  Created by Hurst, Darren on 2023-08-02.
//

import Foundation
import SwiftUI
 
@available(iOS 16, *)
struct WelcomeText : View {
    @ObservedObject var data: SampleData
    
    var body: some View {
        GeometryReader { r in
      
                VStack {
                    Text("Hey, \(data.name)").frame(width: r.size.width, alignment: .topLeading)
                    Text("Welcome Back! 👋").frame(width: r.size.width, alignment: .topLeading)
                }
           
        }
    }
}

struct ReOrder: View {
    let name = "Burger King"
    let description = "2 Large Fries"

    var body: some View {
        HStack {
            
            VStack{
                Text(name)
                Text(description)
            }.padding(2.0)
                .border(.thickMaterial, width: 5.0)
                .cornerRadius(5.0)
            
            VStack{
                Text(name)
                Text(description)
            }.padding(2.0)
                .border(.thickMaterial, width: 5.0)
                .cornerRadius(5.0)
            
            VStack{
                Text(name)
                Text(description)
            }
                    .padding(2.0)
                    .border(.thickMaterial, width: 5.0)
                    .cornerRadius(5.0)
           
        }
    }
}


struct HeaderView: View {
    var body: some View {
        VStack {
            Text("Welcome to SPM Workflow").font(.largeTitle).fontWeight(.bold)
        }
    }
}

@available(iOS 16, *)
struct PreviewWelcomeText: PreviewProvider {
    
    static var previews: some View {
        WelcomeText(data: SampleData())
    }
}

struct Hero: View {
    var body: some View {
        VStack {
            Image("mo", bundle: Bundle.module).resizable()
        }
    }
}
struct PreviewBasketBrandView: PreviewProvider {
    static var previews: some View {
        Hero()
    }
}

struct PreviewReOrderView: PreviewProvider {
    static var previews: some View {
        ReOrder()
    }
}

