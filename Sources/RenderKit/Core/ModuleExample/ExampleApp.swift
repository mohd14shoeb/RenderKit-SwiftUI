import Foundation
import SwiftUI

enum Routes: StringLiteralType, CaseIterable {
    case home = "Home"
    case orders = "Movies"
    case burgers = "Burgers"
    
}

extension Routes: Identifiable {
  var id: Self { self }
}

@available(iOS 16.0, *)
struct RenderToolBarNav: Identifiable, View {
    var id = UUID()
    @State var selectedRoute: Routes = .home
    @ObservedObject var data: SampleData = SampleData()
    
    var body: some View {
        view(for: selectedRoute)
    }
   
    @ViewBuilder
    public func view(for selectedRoute: Routes?) -> some View {
        switch selectedRoute {
        case .some(.home):
            let workflow = [
                Workflow(.headerView),
                Workflow(.welcomeButton),
                Workflow(.menuItem)
            ]
            RenderTable( myStyle: .plain, workflows: workflow, data: data, sectionSeperator: .hidden)
        case .some(.orders):
            let moduleWorkflow = [
                ModuleWorkFlow(.header)
            ]
            RenderTable( myStyle: .plain, workflows: moduleWorkflow, data: data, sectionSeperator: .hidden)
        case .some(.burgers):
            CartView().offset(y:30)
        default:
           EmptyView()
        }
    }
    
}

@available(iOS 16.0, *)
struct RenderToolBar: View {
    @State var toolbar: RenderToolBarNav = RenderToolBarNav(selectedRoute: .home)
    let iconSize = 55.0
    let iconPadding = 0.0

    var body: some View {
        VStack {
            GeometryReader { reader in
                VStack {
                    toolbar.view(for: toolbar.selectedRoute)
                        .allowsHitTesting(true)
                        .frame(height: reader.size.height-80,alignment: .top)
                        .background(Config().background)
                    HStack {
                        ForEach(Routes.allCases) { route in
                  
                            VStack {
                              
                                if isSelected(route: route) {
                                    VStack {
                                        Config().background
                                            
                                    }
                                    .frame(height:3.0)
                                    //.offset(y:-5)
                            }
                            Button(action: {
                                toolbar = RenderToolBarNav(selectedRoute: route)
                            }) {
                                ViewThatFits {
                                    VStack {
                                        switch route {
                                        case .home:
                                            RenderButton(image:Image(systemName: "house"), shape: Circle(), action: {
                                                toolbar = RenderToolBarNav(selectedRoute: route)
                                            })
                                           
                                        case .orders:
                                            RenderButton(image:Image(systemName: "menucard"), shape: Circle(), action: {
                                                toolbar = RenderToolBarNav(selectedRoute: route)
                                            })
                                          
                                        case .burgers:
                                            RenderButton(image:Image(systemName: "burst"), shape: Circle(), action: {
                                                toolbar = RenderToolBarNav(selectedRoute: route)
                                            })
                                          
                                        }
                                        Text(route.rawValue)
                                            .foregroundColor(route == toolbar.selectedRoute ? .black : Config().backgroundColor)
                                    }.animation(Animation.linear(duration: 0.5), value: isSelected(route: route))
                                }
                                .frame(width:reader.size.width / CGFloat(Routes.allCases.count))
                                }
               
                            }
                        }
                    }.frame(width: reader.size.width, height: 80, alignment: .bottom) 
                        .foregroundColor(.black)
                        
                }  .offset(y:-20)
            }
            .background(.white)
        }
    
        .ignoresSafeArea()
      
    }
    
    func isSelected(route: Routes) -> Bool {
        toolbar.selectedRoute == route
    }
}



@available(iOS 16.0, *)
struct RenderToolBarPreview: PreviewProvider {
    static var view: RenderToolBarNav = RenderToolBarNav(selectedRoute: .home)
    static var previews: some View {
        RenderToolBar(toolbar: view)
    }
}

