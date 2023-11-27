//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-11-23.
//

import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct GridDisplay: View  {
    
    @ObservedObject var data: SampleData
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: data.selectedMovie?.poster ?? data.moviePosters[0].poster )) {  phase in
                if let image = phase.image {
                    image.resizable().scaledToFit().onTapGesture {
                    } // Displays the loaded image.
                    .animation(Animation.easeIn(duration: 0.5))
                } else if phase.error != nil {
                    Text("Error in loading url for id: \(data.moviePosters[0].id)")
                } else {
                    Color.blue // Acts as a placeholder.
                }
             
                RENDERGrid(data: data, itemPerRow:15)
            }
        }
    }
}

@available(iOS 16.0, *)
struct GridDisplayPreview: PreviewProvider {
 
    static var previews: some View {
        GridDisplay(data: SampleData())
    }
}
