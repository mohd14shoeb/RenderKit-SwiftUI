import Foundation
import SwiftUI



@available(iOS 16.0, *)
struct SearchProduct: View {
    var body: some View {
        let workflow: [ShopWorkFlow] = [
            ShopWorkFlow(.search),
            ShopWorkFlow(.results)
        ]
        RenderTable<ShopWorkFlow>(myStyle: .plain, workflows: workflow, data: SampleData(), sectionSeperator: Visibility.hidden)
            .ignoresSafeArea()
            .padding(-24)
            .offset(y:-40)
            }
}

@available(iOS 16.0, *)
struct PreviewSearchProduct : PreviewProvider {
    static var previews: some View {
        SearchProduct()
    }
}

