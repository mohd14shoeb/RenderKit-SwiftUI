//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-11-21.
//

import Foundation
import SwiftUI

struct ChuckNorrisJoke: Codable {
    let value: String
}

@available(iOS 16.0, *)
struct Jokes: View {
    @State private var joke: ChuckNorrisJoke? = nil
    @State var showAlert: Bool = false

    var body: some View {
        
        GeometryReader { r in
            VStack {
                Text(joke?.value ?? "")
                    .padding(10)
                    .font(.title3)
                    .frame(width:r.size.width,height:r.size.height)
                    .opacity(showAlert ? 0.0 : 1.0)
                    
                Button("Next One!") {
                    showAlert = true
                    Task {
                        do {
                            let chuckNorrisJoke: ChuckNorrisJoke = try await Network().fetch(from: Endpoints.chuckNorris.rawValue)
                            joke = chuckNorrisJoke
                            
                        } catch {
                            print(error)
                        }
                    }
                }
                .offset(y:-150)
                .buttonStyle(.borderedProminent)
            }
            .frame(width:r.size.width,height:r.size.height)
            .navigationTitle("Chuck Norris Jokes")
            .overlay(
                VStack{
                    Alert("Getting a new Chuck Norris joke", okBtn: {
                        showAlert = false
                    })
                }
                .frame(width:r.size.width, height: r.size.height)
                .opacity(showAlert ? 1.0 : 0.0))
            .animation(Animation.linear(duration: 0.1), value: showAlert)
           
        }
    }
      
    
         
}

@available(iOS 16.0, *)
struct joke: PreviewProvider {
    static var previews: some View {
      Jokes()
    }
}

