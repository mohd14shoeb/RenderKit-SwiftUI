
import Foundation
import SwiftUI

@available(iOS 16.0, *)
public struct RENDERTable<T: Identifiable>: View {
    @State var myStyle: TableListStyle = TableListStyle.plain
    var backgroundColor: Color = Color.blue.opacity(0.1)
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
                                        VStack {
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
                                        }
                                    })
                                .listRowSeparator(sectionSeperator)
                                .listRowBackground(backgroundColor)
                           
                            }
                            .padding(.top,50)
                             
                            .listStyle(myStyle.style)
                            .anyView
                        }
                        .backButton()
                     
                    }
                    
            }
    }
}

extension View {
    var anyView: AnyView {
        AnyView(self)
    }
}



