//
//  File.swift
//  
//
//  Created by Darren Hurst on 2023-11-08.
//

import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct Alert: View, Identifiable {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var id: UUID = UUID()
    var text: String
    var okBtn:() -> Void
    var cancelBtn:(()->())?
    @State var controls: Int = 0
    
    let minH: CGFloat = 140
    let offset: CGFloat = -20
    
    init(_ text: String, okBtn: @escaping () -> Void) {
        self.text = text
        self.okBtn = okBtn
    }
    
    // override for optional closure
    init(_ text: String, okBtn: @escaping () -> Void , cancelBtn: (()->())?) {
        self.text = text
        self.okBtn = okBtn
        self.cancelBtn = cancelBtn
    }
    
    var body: some View {
        VStack {
            HStack {
                
                ZStack {
                    Image(systemName:"pencil")
                        .background(Circle().stroke(style:(StrokeStyle(lineWidth: 2))).padding(-25))
                        .padding()
                        .scaledToFit()
                        .foregroundColor(Color.black)
                        .frame(minWidth: 60)
                        .offset(y:offset)
                }
                .padding(.leading)
                
                Text(text)
                    .foregroundColor(Color.black)
                    .accessibility(label: Text(text))
                    .padding()
                    .offset(y:-20)
            }
            .frame(minHeight: minH)
            .background(Rectangle().fill(Color.gray.opacity(0.99)))
       
            GeometryReader { r in
                HStack {
                     
                     if let action = cancelBtn as? () -> Void {
                         RENDERButton(id: UUID(), text: "Cancel", image: nil, action: action).foregroundColor(Color.black)
                             .frame(width: r.size.width / 2 - 20)
                             .onTapGesture {
                                 presentationMode.wrappedValue.dismiss()
                             }.onAppear(){
                                 self.controls = 1
                             }
                     }
                    
                    if let okaction = okBtn as? () -> Void {
                        RENDERButton(id: UUID(), text: "OK", image: nil, action: okaction).foregroundColor(Color.black)
                            .frame(width: self.controls == 1 ? r.size.width / 2 - 20 : r.size.width)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }.padding(20)
                    .background(Rectangle().stroke(.blue, style: StrokeStyle(lineWidth: 1.0)).background(Color.white).cornerRadius(5.0))
                .frame(width: r.size.width)
                .offset(y:offset)
            }
            .frame( height: 30)
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .ignoresSafeArea()
        .padding(.top, 20)
        .background(Rectangle().fill(Color.gray))
    }
}

// Cancel and Ok add to Localization
//

@available(iOS 16.0, *)
struct AlertPreview : PreviewProvider {
    static var previews : some View {
        Alert("Sorry.  This is a information message. Please contact customer support.",
              okBtn: {
                // do something
              }
              // optional add cancel)
              // (()->())?
             ,cancelBtn: {}
        )
    }
}
