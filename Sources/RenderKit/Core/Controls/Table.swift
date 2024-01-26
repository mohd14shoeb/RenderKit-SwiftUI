
import Foundation
import SwiftUI

@available(iOS 16.0, *)
public struct RenderTable<T: Identifiable>: View {
    @State var myStyle: TableListStyle = TableListStyle.plain
    var backgroundColor: Color = Color.blue.opacity(0.1)
    @State var workflows: [T] = []
    @ObservedObject var data: SampleData
    var sectionSeperator: Visibility
    
   
   public var body: some View {
        NavigationStack {
            List($workflows.wrappedValue) { flow in
                Section(
                    content: {
                        VStack {
                            
                        
                            if let flow = flow as? Workflow {
                                render(flow: flow)
                             }
                            
                            if let flow = flow as? ShopWorkFlow {
                                render(flow: flow)
                            }
                          
                            if let flow = flow as? ModuleWorkFlow {
                                flow.view(for: flow.component, data: data)
                                    .background(.clear)
                                    .accessibility(label: Text(""))
                            }
                        /*
                            else if let flow = flow as? ShopWorkFlow {
                                flow.view(for: flow.component, data: data)
                            }
                        */
                        
                        
                        }
                    })
                .listRowSeparator(sectionSeperator)
            //   .listRowBackground(Config().background.opacity(0.2))
            }
            .listStyle(myStyle.style)
            .anyView
        }
        .backButton()
    }
}

@available(iOS 16.0, *)
extension RenderTable {
    func render(flow: Workflow) -> some View {
        flow.view(for: flow.component, data: data)
    }
    
    func  render(flow: ShopWorkFlow) -> some View {
        flow.view(for: flow.component, data: data)
    }
       /* if let flow = flow as? Workflow  {
            flow.view(for: flow.component, data: data)
        }
        else if let flow = flow as? ModuleWorkFlow {
            flow.view(for: flow.component, data: data)
                .background(.clear)
                .accessibility(label: Text(""))
        }
        else if let flow = flow as? ShopWorkFlow {
            flow.view(for: flow.component, data: data)
        }*/
    
    
}

 
extension View {
    var anyView: AnyView {
        AnyView(self)
    }
}



