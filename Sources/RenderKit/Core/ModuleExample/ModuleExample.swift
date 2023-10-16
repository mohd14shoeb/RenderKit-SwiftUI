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
    case header = "THIS IS A HERO"
   
}

@available(iOS 16, *)
public struct ModuleWorkFlow: Equatable, Hashable, Identifiable {
    public var id = UUID()
    public var featureName: String = "ThisFeature"
    public var component: ModuleComponents = .welcome
    @ViewBuilder
    public func view(for destination: ModuleComponents?, data: SampleData) -> some View {
        switch destination {
        case .some(.welcome):
            WelcomeText(data: data)
        case .some(.login):
            RENDERForm()
        case .some(.header):
            VStack {
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
        default:
            EmptyView()
        }
    }
}

@available(iOS 16.0, *)
struct previewComponent: PreviewProvider {
    static var previews: some View {
        let moduleWorkflow = [ModuleWorkFlow(component: .header), ModuleWorkFlow(component: .login)]
        VStack {
            RENDERTable( myStyle: TableListStyle.grouped, workflows: moduleWorkflow, sampleData: SampleData(), sectionSeperator: Visibility.hidden)
        }
    }
}

@available(iOS 16.0, *)
struct RENDERForm: View {
    @AppStorage("loginName") private var loginName: String = ""
    @AppStorage("password") private var password: String = ""
    
    @State  var authenticated: Bool = false

    var body: some View {
        VStack {
            GeometryReader() { reader in
                if !$authenticated.wrappedValue {
                    VStack {
                        TextField("Login", text: $loginName)
                            .background(Color.blue.opacity(0.2)).frame(height:20)
                            .padding(.bottom, 10)
                        TextField("Password", text: $password)
                            .background(Color.blue.opacity(0.2)).frame(height:20)
                            .padding(.bottom, 10)
                        Button(action: {
                            self.authenticated.toggle()
                        }, label: {
                            Text("Login").frame(width: reader.size.width, height:20).padding(10)
                        })
                        .contentShape(Rectangle())
                        .background(Color.blue.opacity(0.2))
                        .frame(width: reader.size.width, height:20)
                        .padding(.top, 10) 
                    }
                    
                } else {
                    WelcomeText(data: SampleData()).onTapGesture {
                        self.authenticated.toggle()
                    }
                }
            }.frame(height: 400)
        }
    }
}
