
import Foundation
import SwiftUI

@available(iOS 16.0, *)
public struct RENDERTable<T: Identifiable>: View {
    @State var myStyle: TableListStyle = TableListStyle.plain
    @State var workflows: [T] = []
    @ObservedObject var sampleData: SampleData
    var sectionSeperator: Visibility
    
    public var body: some View {
                GeometryReader { r in
                    NavigationStack  {
                        List($workflows.wrappedValue) { flow in
                            Section(
                                content: {
                                    
                                    if let flow = flow as? Workflow {
                                        flow.view(for: flow.component, data: sampleData).allowsHitTesting(true)
                                    }
                                    else if let flow = flow as? ModuleWorkFlow {
                                        flow.view(for: flow.component, data: sampleData)
                                    }
                                    
                                })
                            .listRowSeparator(sectionSeperator)
                        }
                        .listStyle(myStyle.style)
                        .listSectionSeparator(sectionSeperator)
                        .anyView
                    }
            }
    }
}

extension View {
    var anyView: AnyView {
        AnyView(self)
    }
}



