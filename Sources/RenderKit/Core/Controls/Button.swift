
import Foundation
import SwiftUI


private struct Config {
 let background = Color.blue.opacity(0.1)
 let textColor = Color.blue
}

@available(iOS 16.0, *)
struct RENDERButton: View, Identifiable {
    var id : UUID = UUID()
    var text: String?
    var image: Image?
    var action: () -> Void
    
    var body: some View {
       ViewThatFits {
           GeometryReader { reader in
                Button(action: action) {
                    HStack {
                        Text(text ?? "")
                            .foregroundColor(Config().textColor)
                            .accessibility(label: Text(text ?? ""))
                        image
                    }
                    .padding(10)
                }
                 
                .contentShape(Rectangle())
                .background(Config().background)
                .frame(width: reader.size.width)
                .padding()
            }
        }
    }
}

@available(iOS 16.0, *)
struct RENDERButtonPreview: PreviewProvider {
    static var previews: some View {
        RENDERButton(action: {
            
        })
    }
}
