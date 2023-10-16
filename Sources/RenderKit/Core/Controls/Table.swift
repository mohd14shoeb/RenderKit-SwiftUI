
import Foundation
import SwiftUI
//import Heap_SwiftUI
//import Heap
@available(iOS 16.0, *)
struct RENDERTable<T: Identifiable>: View {
    @State var myStyle: TableListStyle = TableListStyle.plain
    @State var workflows: [T] = []
    @ObservedObject var sampleData: SampleData
    var sectionSeperator: Visibility
    
    public var body: some View {
        VStack {
            NavigationStack {
                GeometryReader { r in
                    List($workflows.wrappedValue) { flow in
                        Section(
                            //header: //Text(flow.component.rawValue).padding(-10),
                            content: {
                                LazyVStack {
                                    if let flow = flow as? Workflow {
                                        RENDERSectionBodyView(view: flow.view(for: flow.component, data: sampleData))
                                    }
                                    else if let flow = flow as? ModuleWorkFlow {
                                        RENDERSectionBodyView(view: flow.view(for: flow.component, data: sampleData))
                                    }
                                }})
                        .padding(20)
                        .listRowSeparator(sectionSeperator)
                    }
                    .listStyle(myStyle.style)
                    .anyView 
                    .listSectionSeparator(sectionSeperator)
                    .frame(height: r.size.height, alignment:.top)
                    .padding(.top, 10)
                   
                }
            }
        }.padding(.top, 60)
        
    }
    
}

extension View {
    var anyView: AnyView {
        AnyView(self)
    }
}



