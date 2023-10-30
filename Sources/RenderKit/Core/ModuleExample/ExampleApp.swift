import Foundation
import SwiftUI

enum Routes: StringLiteralType, CaseIterable {
    case home = "Home"
    case orders = "Orders"
    case burgers = "Burgers"
    
}

extension Routes: Identifiable {
  var id: Self { self }
}

@available(iOS 16.0, *)
struct RENDERToolBarNav: Identifiable, View {
    var id = UUID()
    @State var selectedRoute: Routes = .home

    var body: some View {
        view(for: selectedRoute)
    }
   
    @ObservedObject var sampleData: SampleData = SampleData()
    @ViewBuilder
    public func view(for selectedRoute: Routes?) -> some View {
        switch selectedRoute {
        case .some(.home):
            let workflow = [
                Workflow(.empty),
                Workflow(.headerView),
                Workflow(.welcome),
                Workflow(.empty),
                Workflow(.empty),
            ]
            RENDERTable( myStyle: .grouped, workflows: workflow, sampleData: sampleData, sectionSeperator: .hidden)
        case .some(.orders):
            let moduleWorkflow = [
                ModuleWorkFlow(.empty),
                ModuleWorkFlow(.empty),
                ModuleWorkFlow(.empty),
                ModuleWorkFlow(.empty),
                ModuleWorkFlow(.login)]
         
            RENDERTable( myStyle: .grouped, workflows: moduleWorkflow, sampleData: sampleData, sectionSeperator: .hidden)
        case .some(.burgers):
             CartView().padding(.top, 50)
        default:
           EmptyView()
        }
    }
    
}

@available(iOS 16.0, *)
struct RENDERToolBar: View {
    @State var view: RENDERToolBarNav = RENDERToolBarNav(selectedRoute: .home)
    let iconSize = 55.0
    let iconPadding = 0.0
   
    var body: some View {
        VStack {
            GeometryReader { reader in
                VStack {
                    view.view(for: view.selectedRoute).allowsHitTesting(true)
                        .frame(height: reader.size.height,alignment: .top).offset(y:-50)
                    HStack {
                        ForEach(Routes.allCases) { route in
                            Button(action: {
                                view = RENDERToolBarNav(selectedRoute: route)
                            }) {
                                VStack {
                                    switch route {
                                    case .home:
                                        Image(systemName: view.selectedRoute == route ? "house.fill" : "house").onTapGesture {
                                            view = RENDERToolBarNav(selectedRoute: route)
                                        }
                                        .foregroundColor(route == view.selectedRoute ? .black : .blue)
                                    case .orders:
                                        Image(systemName: view.selectedRoute == route ? "menucard.fill" : "menucard").onTapGesture {
                                            view = RENDERToolBarNav(selectedRoute: route)
                                        }
                                        .foregroundColor(route == view.selectedRoute ? .black : .blue)
                                    case .burgers:
                                        Image(systemName: view.selectedRoute == route ? "burst.fill" : "burst").onTapGesture {
                                            view = RENDERToolBarNav(selectedRoute: route)
                                        }
                                        .foregroundColor(route == view.selectedRoute ? .black : .blue)
                                    }
                                    Text(route.rawValue)
                                        .foregroundColor(route == view.selectedRoute ? .black : .blue)
                                }
                         
                                .frame(width:reader.size.width / CGFloat(Routes.allCases.count))
                                
                                
                            }
                        }
                    }.frame(width: reader.size.width, height: 50, alignment: .bottom)
                        .padding(.top,10)
                        .padding(.bottom,10)
                        .foregroundColor(.black)
                        .background(.gray.opacity(0.05))
                        .offset(y:-60)
                }.frame(alignment: .leading)
                
            }
            
        } 
    }
}

@available(iOS 16.0, *)
struct RENDERToolBarPreview: PreviewProvider {
    static var view: RENDERToolBarNav = RENDERToolBarNav(selectedRoute: .home)
    static var previews: some View {
        RENDERToolBar(view: view)
    }
}

@available(iOS 15.0, *)
struct BackButton: View {
    var dismissAction: () -> Void
    
    var btnBack : some View { Button(action: {
            self.dismissAction()
        }) {
           HStack {
               Image(systemName: "arrow.left")
               //Image(systemName: "chevron.left.circle")
               .aspectRatio(contentMode: .fit)
               .foregroundColor(.black)
               Text("insert Nav Title")
           }.background(.clear)
           //.border(.bar, width: 2)
           .foregroundColor(.black)
        }
    }
    
    var btnBackRoot : some View { Button(action: {
            self.dismissAction()
        }) {
           HStack {
               
           }.background(.clear)
           //.border(.bar, width: 2)
           .foregroundColor(.black)
        }
    }
    var body: some View {
        VStack {
            AnyView {
                btnBack
            }
        }
    }
    
   

}

@available(iOS 16.0, *)
struct NavigationBack: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
    func body(content: Content) -> some View {
        content
            .navigationTitle(Text(""))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(dismissAction: {
                self.presentationMode.wrappedValue.dismiss()
            }).btnBack)
            
    }
}

@available(iOS 16.0, *)
struct NavigationBackRoot: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
 
    func body(content: Content) -> some View {
        content
            .navigationTitle(Text(""))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(dismissAction: {
                self.presentationMode.wrappedValue.dismiss()
            }).btnBackRoot)
    }
}

@available(iOS 16.0, *)
extension View {
    // install on view with .backButton()
    func backButton() -> some View {
        modifier(NavigationBack())
    }
    
    func backButtonRoot() -> some View {
        modifier(NavigationBackRoot())
    }
}


