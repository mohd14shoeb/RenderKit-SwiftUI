//
//  File.swift
//
//
//  Created by Darren Hurst on 2023-11-04.
//  Currently this is just a grid generator, based on data size and defined per row

import Foundation
import SwiftUI

fileprivate extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension Array: Identifiable where Element: Hashable {
   public var id: Int { self.hashValue }
}

@available(iOS 16.0, *)
struct RENDERGrid : View {
    @ObservedObject var data: SampleData
    
    let gradient = Gradient(colors: [.yellow, .yellow, .white, .white])

        var body: some View {

            let itemPerRow = 4
            let movieset = data.moviePosters.chunked(into: itemPerRow)
     
            ViewThatFits {
            GridLayout(alignment: .topLeading, horizontalSpacing: 2.0, verticalSpacing:2.0){
    
                ForEach(movieset) {  rowdata in
                    let movies = rowdata
                    GridRow {
                        ForEach (movies) { movie in
                          
                                AsyncImage(url: URL(string: movie.poster)) {  phase in
                                    if let image = phase.image {
                                        image.resizable().scaledToFit() // Displays the loaded image.
                                    } else if phase.error != nil {
                                        Text("Error in loading url for id: \(movie.id)")
                                    } else {
                                        Color.blue // Acts as a placeholder.
                                    }
                                }
                            
                        }
                    }
                }
                
        }.padding(10)
    }
        
    }
}
@available(iOS 16.0, *)
struct previewGrid: PreviewProvider {
 
    static var previews: some View {
        RENDERGrid(data: SampleData())
    }
}

