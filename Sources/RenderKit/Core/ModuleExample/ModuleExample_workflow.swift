import Foundation
import SwiftUI

@available(iOS 16.0, *)
public enum Components: StringLiteralType {
    case welcome = "Welcome Text"
    case headerView = "Lets get started"
    case menuItem = "Best Burgers "
    case empty = "nil"
}


public struct ID<T>: Equatable {
    private let value = UUID()
}

@available(iOS 16.0, *)
public struct Workflow : View, Identifiable {
    
    public var id = UUID()
    public var component: Components = .welcome
    
    var sectionHeader: (any View)?
    var sectionFooter: (any View)?
    public var body: some View {
        VStack {}
    }
  
    //Table View
    @ViewBuilder
    public func view(for destination: Components?, data: SampleData) -> some View {
        switch destination {
        case .some(.welcome):
            WelcomeText(data: data)
            RENDERButton(text: "Change Name", image: nil, action: {
                data.name = data.name == "Darren" ? "Frankie Bananas" : "Darren"
            })
         case .some(.headerView):
            RENDERNavigationLink(ModuleWorkFlow(.header), data: data)
            HeaderView()
        case .some(.menuItem):
           CartView().allowsHitTesting(true)
        default:
          EmptyView()
        }
    }
    
    //AnyView Passthrough
    @ViewBuilder
    public func view(for body: any View, data: SampleData) -> some View {
         AnyView(body)
    }
    
    //Routing
    @ViewBuilder
    public func componentLanding(view: Components?, data: SampleData) -> some View {
        switch view {
        case .some(.menuItem):
            let myBurger: Burger = Burger(burger: BaconburgerBuilder())
            CartView()
        default:
            EmptyView()
        }
    }
}

@available(iOS 16.0, *)
extension Workflow: Equatable {
    public static func == (lhs: Workflow, rhs: Workflow) -> Bool {
        return lhs.component == rhs.component
    }
    
    public init(_ component: Components) {
        self.component = component
    }
}
