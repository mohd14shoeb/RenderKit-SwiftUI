//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-11-08.
//

import Foundation

import Foundation
import SwiftUI

enum Priority:  CaseIterable {
    static var allCases: [Color] {
        return [.green, .yellow, .red]
        }
    var id: Self {
                return self
            }
    case all
}

struct Toast: View {
    @State var showToast: Bool = false
    var message: String?
    var priority : Int = 2 //low -> 2 high
  
    var body: some View {
        GeometryReader { r in
            VStack {
                // build a drop down, or popup style Navigation Toast
                HStack {
                    Image(systemName:"toast")
                        .background(Circle().stroke(style:(StrokeStyle(lineWidth: 2)))
                            .background(Circle().fill(Priority.allCases[priority].opacity(0.5)))
                            .padding(-15)
                            //.offset(y:showToast ? -0 : -40)
                        )
                        .padding(.trailing, 2.0)
                    Text(message ?? "If you want to toast this toast..")
                       //.offset(y:showToast ? -0 : -40)
                        .padding(20)
                }
                
                //.offset(y:showToast ? -0 : -40)
                
            }
            .frame(minWidth: r.size.width, minHeight: 40)
            .background( Rectangle().fill(Color.blue.opacity(0.2)))
            .onAppear(){
                showToast = true
            }
            .onTapGesture() {
                showToast = showToast ? false : true
            }
            .offset(y:showToast ? -0 : -120)
            .animation(Animation.easeIn(duration: 0.8))
        }
    }
}

struct ToastPreview : PreviewProvider {
    static var previews : some View {
        VStack {
            Toast(priority: 0)
            //Toast(priority: 1)
            //Toast(priority: 2)
        }
    }
}
