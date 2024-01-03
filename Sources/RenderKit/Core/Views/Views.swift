//
//  File.swift
//  
//
//  Created by Hurst, Darren on 2023-08-02.
//

import Foundation
import SwiftUI
 
@available(iOS 16.0, *)
struct View1: View {
    @ObservedObject var sampleData: SampleData
  
    public var body: some View {
        Color(.red)
        ZStack {
        }.frame(height:0)
    }
}
 
@available(iOS 16.0, *)
struct View2: View {
    @ObservedObject var sampleData: SampleData
  
    public var body: some View {
        Color(.blue)
        ZStack {
            let workflow: [Workflow] = []
            RenderTable(myStyle: .plain, workflows: workflow, data: sampleData, sectionSeperator: .visible)
        }
    }
}

@available(iOS 16.0, *)
struct View3: View {
    @ObservedObject var sampleData: SampleData
  
    public var body: some View {
        VStack {
            let workflow = [
                ModuleWorkFlow(.header),
                ModuleWorkFlow(.login)]
            RenderTable(myStyle: .inset, workflows: workflow, data: sampleData, sectionSeperator: .hidden)
        }
    }
}


