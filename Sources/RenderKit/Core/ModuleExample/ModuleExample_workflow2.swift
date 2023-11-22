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
    case login = "Login"
    case header = "Chuck Norris Jokes "
    case alert = "Alert"
    case empty = "empty"
    case jokes = "Jokes"
   
}

@available(iOS 16, *)
public struct ModuleWorkFlow: Equatable, Hashable, Identifiable {
    public var id = UUID()
    public var featureName: String = "ThisFeature"
    public var component: ModuleComponents = .welcome
    
    enum endpoints: StringLiteralType {
        case chuckNorris = "https://api.chucknorris.io/jokes/random"
    }
    
    init(_ component: ModuleComponents) {
        self.component = component
    }
    
    @ViewBuilder
    public func view(for destination: ModuleComponents?, data: SampleData) -> some View {
        switch destination {
        case .some(.welcome):
            WelcomeText(data: data)
        case .some(.jokes):
            Jokes()
        case .some(.alert):
        
                Alert("This is just here showing a in table placement :)", okBtn: {
                    
                }, cancelBtn: {
                    
                })
        case .some(.header):
            VStack {
                Image("mo", bundle: Bundle.module).resizable()
                Text("Thanks for checking out this generated composable tableview and section builder render kit. It's a work in progress")
                Spacer()
                GeometryReader { r in
                    VStack {
                        Text("Working on ViewThatFits with Nagivation and Split Navigation").font(.Small).frame(width: r.size.width, alignment:.top)
                        Text("Working on more controls").font(.Small).frame(width: r.size.width, alignment:.leading)
                        Text("** just updated to NavigationStack").font(.Small).frame(width: r.size.width, alignment:.leading)
                    }.frame(height: r.size.height)
                   
                }
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
        case .some(.header):
            Jokes()
        case .some(.alert):
            let moduleWorkflow = [
                ModuleWorkFlow(.alert)]
         
            RENDERTable( myStyle: .grouped, workflows: moduleWorkflow, data: data, sectionSeperator: .hidden).anyView
        case .some(.header):
            let moduleWorkflow = [
                ModuleWorkFlow(.alert)]
         
            RENDERTable( myStyle: .grouped, workflows: moduleWorkflow, data: data, sectionSeperator: .hidden).anyView
        default:
            EmptyView()
        }
    }
}

@available(iOS 16.0, *)
struct previewComponent: PreviewProvider {
    static var previews: some View {
        let moduleWorkflow = [ModuleWorkFlow(.jokes), ModuleWorkFlow(.header)]
        VStack {
            RENDERTable( myStyle: TableListStyle.grouped, workflows: moduleWorkflow, data: SampleData(), sectionSeperator: Visibility.visible)
        }
    }
}

