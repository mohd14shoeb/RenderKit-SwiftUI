
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
                        if text != nil {
                            Text(text ?? "")
                                .foregroundColor(Config().textColor)
                                .accessibility(label: Text(text ?? ""))
                        }
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
        HStack{
            RENDERButton(text: "Back", action: {}).frame(alignment:.leading)
                .offset(x:-15)
            RENDERButton(image: Image(systemName:"house"), action: {})
            RENDERButton(text: "Click Me", image: Image(systemName:"pencil"), action: {})
                .offset(x:-10)
        }.offset(x:-15)
    }
}
