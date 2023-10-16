import SwiftUI

@available(iOS 16, *)
public struct RENDERKit {
    public init( ) {
    }
    // let table = Table(Components: [Workflow]
    // returns Table view as Any
   
    public func tableViewForWorkflow<T: Identifiable>(flow: [T]) -> any View {
        return AnyView(
            GeometryReader { r in
                ScrollView(.vertical) {
                    NavigationView {
                        RENDERTable( myStyle: .plain, workflows: flow, sampleData: SampleData(), sectionSeperator: .hidden)
                    }.frame(height: r.size.height)
                }
            }
        )
    }
    
    public func toolBarForNavigation(view: any View) -> any View {
        let view = RENDERToolBarNav(selectedRoute: .home)
        return RENDERToolBar(view: view)
    }
}
