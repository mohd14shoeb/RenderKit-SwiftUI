# RENDERKit SPM Workflow sample

A description of this package.


https://github.com/DarrenHurst/RenderKit/assets/1024006/5ea1f734-7235-4a46-979f-1f5acca24615



Examples of Internal View builder creation in Core/ModuleExample

1.  app in a spm, rendering a toolbar and seperate flows
2.  tableView creation of spm module flows by exposing in spm interface.

Load package in xcode, swift tools are xcode 14 swift-tools-version: 5.7

just add the package. 
https://github.com/DarrenHurst/RenderKit

import RENDERKit

        let render = RENDERKit()
        let moduleWorkflow = [render.getModuleWorkFlow(component: .header), render.getModuleWorkFlow(component: .login)]
     
        VStack {
            //Currently working on local table generation
          AnyView(render.tableViewForWorkflow(flows: moduleWorkflow))
          // Run a toolbar nav
          // AnyView(RENDERKit().toolBarForNavigation(view: self))
        }
        .padding()


Creating Workflow and describing composeable components

    public func tableViewForWorkflow<T>(flow: [T]) -> any View {
        return AnyView(
            GeometryReader { r in
                ScrollView(.vertical) {
                    NavigationView {
                        RENDERTable( 
                            myStyle: .plain,
                            workflows: flow,
                            sampleData: SampleData(),
                             sectionSeperator: .hidden)
                    }.frame(height: r.size.height)
                }
            }
        )
    }
    
    public func toolBarForNavigation(view: any View) -> any View {
        let view = RENDERToolBarNav(selectedRoute: .home)
        return RENDERToolBar(view: view)
    }

This package currently generates the Toolbar and it's view inside the SPM Dependency

### TODO

Make a API to Generate a TableView,  The view will be added to the Generative Flow from the App side.

