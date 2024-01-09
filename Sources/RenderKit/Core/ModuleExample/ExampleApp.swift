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
                //Workflow(.headerView),
                Workflow(.welcomeButton),
             
            ]
            
            RenderTable( myStyle: .plain, workflows: workflow, data: data, sectionSeperator: .hidden)
        case .some(.orders):
            let moduleWorkflow = [
                ModuleWorkFlow(.header)
            ]
            
            SegmentedControl(data: SampleData(), shape: Capsule(), sections: [
                
                Sections(id:0, title: "Welcome", view: HeaderView()),
                Sections(id:1, title: "Movies", view:   RenderTable( myStyle: .plain, workflows: moduleWorkflow, data: data, sectionSeperator: .hidden).offset(y:-40)
                   ),
                Sections(id:2, title: "Map", view: MapView(location: Location()))
            ]).offset(y:80)
            
          
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
    @State var animate: Bool = false
    @State var showToast: Bool = true
   
    let iconSize = 55.0
    let iconPadding = 0.0

    var body: some View {
        VStack {
            GeometryReader { reader in
                VStack {
                   
                    toolbar.view(for: toolbar.selectedRoute)
                        .allowsHitTesting(true)
                        .frame(height: reader.size.height-80,alignment: .top)
                        //.background(Config().background)
                       // .offset(x: animate ? 0 : -400)
                        .animation(.easeIn.speed(0.55), value: animate)
                        .onAppear() {
                            animate = true
                        }
                    Toast(showToast: true, message: "Did you get a new Chuck Norris joke?", priority: 0).offset(y:showToast ? -650 : -800)

                    HStack(alignment: .center) {
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
                    }.frame(width: reader.size.width, height: 90, alignment: .bottom)
                        .foregroundColor(.black)
                        .background(.white)
                }  .offset(y:-40)
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

