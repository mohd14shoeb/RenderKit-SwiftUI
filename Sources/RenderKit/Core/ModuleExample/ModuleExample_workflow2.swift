//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-10-13.
//

import Foundation
import SwiftUI

@available(iOS 16.0, *)
public enum ModuleComponents: StringLiteralType, CaseIterable, Identifiable {
    public var id: Self {
        return self
    }
    case welcome = "Welcome Text"
    case login = ""
    case header = "Navigation Links"
    case empty = "empty"
   
}

@available(iOS 16, *)
public struct ModuleWorkFlow: Equatable, Hashable, Identifiable {
    typealias name = Workflow
    public var id = UUID()
    public var featureName: String = "ThisFeature"
    public var component: ModuleComponents = .welcome
   
    init(_ component: ModuleComponents) {
        self.component = component
    }
    
    @ViewBuilder
    public func view(for destination: ModuleComponents?, data: SampleData) -> some View {
        switch destination {
        case .some(.welcome):
            WelcomeText(data: data)
        case .some(.login):
            RENDERForm(data: data)
        case .some(.header):
            VStack {
                Image("mo", bundle: Bundle.module).resizable()
                Text("Thanks for checking out this generated composable tableview and section builder render kit. It's a work in progress")
            }
        default:
            EmptyView()
        }
    }
}

@available(iOS 16, *)
extension ModuleWorkFlow {
    //Routing by component landing
    @ViewBuilder
    public func componentLanding(view: ModuleComponents?, data: SampleData) -> some View {
        switch view {
        case .some(.login):
            View2(sampleData: data)
        case .some(.welcome):
            View3(sampleData: data)
        case .some(.header):
            let moduleWorkflow = [
                ModuleWorkFlow(.empty),
                ModuleWorkFlow(.login)]
         
            RENDERTable( myStyle: .grouped, workflows: moduleWorkflow, sampleData: data, sectionSeperator: .hidden).anyView
        default:
            EmptyView()
        }
    }
}

@available(iOS 16.0, *)
struct previewComponent: PreviewProvider {
    static var previews: some View {
        let moduleWorkflow = [ModuleWorkFlow(.header), ModuleWorkFlow(.welcome)]
        VStack {
            RENDERTable( myStyle: TableListStyle.grouped, workflows: moduleWorkflow, sampleData: SampleData(), sectionSeperator: Visibility.visible)
        }
    }
}
