# Components

A description of this package.

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

