import Foundation
import SwiftUI

@available(iOS 16.0, *)
public enum ShopComponents: StringLiteralType, CaseIterable, Identifiable {
    public var id: Self {
        return self
    }
    case none = "none"
    case search = "search"
    case results = "results"
}

@available(iOS 16, *)
public struct ShopWorkFlow: Identifiable {
    public var id = UUID()
    public var featureName: String = "SearchFeature"
    public var isEnabled: Bool = true
    typealias type = Workflow
    
    @State var searchText: String = "What are you looking for?"
    public var component: ShopComponents = .none
    public var data: SampleData = SampleData()
    
    //enum endpoints: StringLiteralType {
        //case chuckNorris = "https://api.chucknorris.io/jokes/random"
    //}
    
    init(_ component: ShopComponents) {
        self.component = component
    }
    
    @ViewBuilder
    public func view(for destination: ShopComponents?, data: SampleData) -> some View {
        switch destination {
        case .some(.search):
            SearchBar(data: data).frame(idealHeight:350)
        case .some(.results):
            SearchBarResults(data: data)
        default:
            EmptyView()
        }
    }
}

@available(iOS 16, *)
extension ShopWorkFlow {
    //Routing by component landing
    @ViewBuilder
    public func componentLanding(view: ShopComponents?, data: SampleData) -> some View {
        switch view {
        default:
            EmptyView()
        }
    }
}

@available(iOS 16.0, *)
struct ShopPreviewComponent: PreviewProvider {
    static var previews: some View {
        let moduleWorkflow = [ShopWorkFlow(.search)
                              ,ShopWorkFlow(.results)
                              ]
        VStack {
            RenderTable( myStyle: TableListStyle.grouped, workflows: moduleWorkflow, data: SampleData(), sectionSeperator: Visibility.visible).ignoresSafeArea()
        }
    }
}


