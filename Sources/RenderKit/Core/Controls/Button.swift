
import Foundation
import SwiftUI


private struct Config {
 let background = Color.blue.opacity(0.1)
 let textColor = Color.blue
}

struct RENDERButton: View, Identifiable {
    var id : UUID = UUID()
    var text: String?
    var image: Image?
    var action: () -> Void
    
    var body: some View {
        GeometryReader { reader in
            Button(action: action) {
                HStack {
                    Text(text ?? "")
                        .foregroundColor(Config().textColor)
                    image
                }
                .padding(10)
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .contentShape(Rectangle()).background(Config().background)
        }
    }
}

struct RENDERButtonPreview: PreviewProvider {
    static var previews: some View {
        RENDERButton(action: {
            
        })
    }
}
