import SwiftUI

@available(iOS 16, *)
public struct RENDERKit {
    public init( ) {
    }
    // let table = Table(Components: [Workflow]
    // returns Table view as Any
    
    public func tableViewForWorkflow<T: Identifiable, D: SampleData>(flows: [T], data: D) -> any View {
   
        return AnyView(
            GeometryReader { r in
                ScrollView(.vertical) {
                    ViewThatFits {
                        NavigationStack {
                            RENDERTable( myStyle: .plain, workflows: flows, data: data, sectionSeperator: .hidden)
                        }.frame(height: r.size.height)
                    }
                }
            }
        )
    }
    
    public func appContext(view: any View) -> any View {
        let view = LoadingPage()
        return view
    }
    
    public func getModuleWorkFlow(component: ModuleComponents) -> ModuleWorkFlow {
        return ModuleWorkFlow(component)
    }
}

