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
                    .font(.title3)
                    .frame(width:r.size.width,height:r.size.height)
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
                }.offset(y:-50)
                
                
                
                .buttonStyle(.borderedProminent)
            }   .padding()
                .frame(width:r.size.width,height:r.size.height)
                .navigationTitle("Chuck Norris Jokes")
                .overlay(
                    VStack{
                        Alert("Getting a new Joke", okBtn: {
                            showAlert = false
                        })
                    }
                        .frame(width:r.size.width, height: r.size.height)
                    .opacity(showAlert ? 1.0 : 0.0))
        }
    }
      
    
         
}

@available(iOS 16.0, *)
struct joke: PreviewProvider {
    static var previews: some View {
      Jokes()
    }
}

