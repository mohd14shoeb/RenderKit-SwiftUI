
import Foundation
import SwiftUI


private struct Config {
 let background = Color.blue.opacity(0.1)
 let textColor = Color.blue
}

@available(iOS 16.0, *)
struct RENDERButton: View, Identifiable {
    var id : UUID = UUID()
    var text: String = "Back"
    var image: Image?
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            let back = NSLocalizedString(text, tableName: nil, bundle: Bundle.main, value: "", comment: "")
            Text(back)
                    .accessibility(label: Text(text))
            image
        }
        .background(Config().background)
        .mask(Rectangle())
    }
}

@available(iOS 16.0, *)
struct RENDERButtonPreview: PreviewProvider {
    static let back = NSLocalizedString("Back", tableName: nil, bundle: Bundle.module, value: "", comment: "")
    static var previews: some View {
        HStack{
            RENDERButton(text: back) {}
            RENDERButton(text: back, image: Image(systemName:"house")) {}
        }
    }
}
