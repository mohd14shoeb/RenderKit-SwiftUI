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
struct RENDERToolBarNav: Identifiable, View {
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
            RENDERTable( myStyle: .plain, workflows: workflow, data: data, sectionSeperator: .hidden)
        case .some(.orders):
            let moduleWorkflow = [
                ModuleWorkFlow(.header)
            ]
            RENDERTable( myStyle: .plain, workflows: moduleWorkflow, data: data, sectionSeperator: .hidden)
        case .some(.burgers):
            CartView().offset(y:30)
        default:
           EmptyView()
        }
    }
    
}

@available(iOS 16.0, *)
struct RENDERToolBar: View {
    @State var toolbar: RENDERToolBarNav = RENDERToolBarNav(selectedRoute: .home)
    let iconSize = 55.0
    let iconPadding = 0.0

    var body: some View {
        VStack {
            GeometryReader { reader in
                VStack {
                    toolbar.view(for: toolbar.selectedRoute)
                        .allowsHitTesting(true)
                        .frame(height: reader.size.height-50,alignment: .top)
                        .background(Config().background)
                    HStack {
                        ForEach(Routes.allCases) { route in
                  
                            VStack {
                              
                                if isSelected(route: route) {
                                    VStack {
                                        Color.blue
                                            
                                    }
                                    .frame(height:3.0)
                                    //.offset(y:-5)
                            }
                            Button(action: {
                                toolbar = RENDERToolBarNav(selectedRoute: route)
                            }) {
                                ViewThatFits {
                                    VStack {
                                        switch route {
                                        case .home:
                                            Image(systemName: toolbar.selectedRoute == route ? "house.fill" : "house").onTapGesture {
                                                toolbar = RENDERToolBarNav(selectedRoute: route)
                                            }
                                            .accessibility(label: Text("Home"))
                                            .foregroundColor(route == toolbar.selectedRoute ? .black : .blue)
                                        case .orders:
                                            Image(systemName: toolbar.selectedRoute == route ? "menucard.fill" : "menucard").onTapGesture {
                                                toolbar = RENDERToolBarNav(selectedRoute: route)
                                            }
                                            .accessibility(label: Text("Order"))
                                            .foregroundColor(route == toolbar.selectedRoute ? .black : .blue)
                                        case .burgers:
                                            Image(systemName: toolbar.selectedRoute == route ? "burst.fill" : "burst").onTapGesture {
                                                toolbar = RENDERToolBarNav(selectedRoute: route)
                                            }
                                            .accessibility(label: Text("Burger"))
                                            .foregroundColor(route == toolbar.selectedRoute ? .black : .blue)
                                        }
                                        Text(route.rawValue)
                                            .foregroundColor(route == toolbar.selectedRoute ? .black : .blue)
                                    }.animation(Animation.linear(duration: 0.5), value: isSelected(route: route))
                                }
                                    .frame(width:reader.size.width / CGFloat(Routes.allCases.count))
                                }
                            }
                        }
                    }.frame(width: reader.size.width, height: 50, alignment: .bottom)
                        .background(Color.white)
                        .foregroundColor(.black)
             
                }  .offset(y:-20)
            }
            
        } .ignoresSafeArea()
      
    }
    
    func isSelected(route: Routes) -> Bool {
        toolbar.selectedRoute == route
    }
}

private struct Config {
    let background = Color.yellow.opacity(0.1)
 let textColor = Color.blue
}

@available(iOS 16.0, *)
struct RENDERToolBarPreview: PreviewProvider {
    static var view: RENDERToolBarNav = RENDERToolBarNav(selectedRoute: .home)
    static var previews: some View {
        RENDERToolBar(toolbar: view)
    }
}

