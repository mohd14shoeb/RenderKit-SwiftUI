
import Foundation
import SwiftUI
 
struct RENDERButton: View {
    var action: () -> Void
    
    var body: some View {
        GeometryReader { reader in
            Button(action: action) {
                HStack {
                    Text("click here")
                    Image(systemName: "house")
                }
            }.frame(width: reader.size.width)
                .contentShape(Rectangle())
        }
    }
}

struct RENDERButtonPreview: PreviewProvider {
    static var previews: some View {
        RENDERButton(action: {
            
        })
    }
}
