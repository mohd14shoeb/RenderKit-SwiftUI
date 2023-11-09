
import Foundation
import SwiftUI

@available(iOS 16.0, *)
public struct RENDERTable<T: Identifiable>: View {
    @State var myStyle: TableListStyle = TableListStyle.plain
    @State var workflows: [T] = []
    @ObservedObject var data: SampleData
    var sectionSeperator: Visibility
    
    public var body: some View {
                GeometryReader { r in
                    ViewThatFits  {
                        NavigationStack {
                            List($workflows.wrappedValue) { flow in
                                Section(
                                    content: {
                                            if let flow = flow as? Workflow {
                                                flow.view(for: flow.component, data: data)
                                                    .allowsHitTesting(true)
                                                    .background(.clear)
                                                    .accessibility(label: Text(""))
                                            }
                                            else if let flow = flow as? ModuleWorkFlow {
                                                flow.view(for: flow.component, data: data)
                                                    .background(.clear)
                                                    .accessibility(label: Text(""))
                                            }
                                       
                                    })
                                .background(.clear)
                                .listRowSeparator(sectionSeperator)
                            }
                            .padding(.top,50)
                            .background(.clear)
                            .listStyle(myStyle.style)
                            .listSectionSeparator(sectionSeperator)
                            .background(.clear)
                            .anyView
                        }.backButton()
                    }
            }
    }
}

extension View {
    var anyView: AnyView {
        AnyView(self)
    }
}



