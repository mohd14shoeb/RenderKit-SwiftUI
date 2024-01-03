
import Foundation
import SwiftUI

 
@available(iOS 16.0, *)
struct RenderButton: View, Identifiable {
    var id : UUID = UUID()
    var text: String?
    var image: Image?
    var shape: (any Shape)? = Rectangle()
    var action: () -> Void
    @State var animate: Bool = false
    var body: some View {
            ZStack {
                Button(action: action) {
                    if text != nil {
                        Text(text ?? "Back")
                            .foregroundColor(animate ? Config().textColor : Config().textColor.opacity(0.5))
                            .animation(.easeIn(duration: 1.0).speed(1.25), value: animate)
                            .padding(Config().padding)
                             
                    }
                    image?
                        .foregroundColor(animate ? Config().textColor : Config().textColor.opacity(0.5))
                        .animation(.easeIn(duration: 1.0).speed(1.25), value: animate)
                        .padding(Config().padding)
                        
                        
                    
                }
                
                .background(
                    shape?
                        .stroke(Config().backgroundBorder, style: StrokeStyle(lineWidth: Config().borderWidth))
                        .opacity(Config().backgroundOpacity)
                        .anyView)
                .background(Config().background.opacity(Config().backgroundOpacity))
                .accessibilityLabel(text ?? "Back")
                .animation(.easeIn(duration: 1.5).speed(1.5), value: animate)
                .cornerRadius(Config().borderCornerRadius)
                .mask(shape?.opacity(Config().backgroundOpacity).anyView)
                .shadow(radius: 5.0)
                .onAppear() {
                     animate = true
                }
               
            }
       
    }
    // Text("\(String(describing: twoSums([2,4,3,6,7],9)))")
    func twoSums(_ nums: [Int],_ target: Int) -> [Int] {
        var tempNums: [Int: Int] = [Int: Int]()
        for (index, num) in nums.enumerated() {
            if let val = tempNums[target - num] {
                return [val, index]
            }
            
            tempNums[num] = index
        }
        return []
    }
}




@available(iOS 16.0, *)
struct RenderButtonPreview: PreviewProvider {
    static let back = NSLocalizedString("Back", tableName: nil, bundle: Bundle.module, value: "", comment: "")
    static var previews: some View {
        HStack{
            RenderButton(text: "Rectangle") {}
            RenderButton(text: "Capsule", shape: Capsule()) {}
            RenderButton(image: Image(systemName:"house"), shape: Circle()) {}
        }
    }
}
