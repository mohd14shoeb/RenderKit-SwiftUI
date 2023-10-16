import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct RENDERSectionBodyView : View {
    var view: any View
    init( view: any View) {
        self.view = view
    }
    var body: some View {
        AnyView(view)
    }
}
