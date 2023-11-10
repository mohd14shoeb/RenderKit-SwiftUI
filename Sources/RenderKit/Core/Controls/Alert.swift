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
    var id: UUID = UUID()
    var text: String
    var okBtn:() -> Void
    var cancelBtn:(()->())?
    
    let minH: CGFloat = 140
    let offset: CGFloat = -20
    
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
                             .accessibility(label: Text("Cancel"))
                     }
                    if let okaction = okBtn as? () -> Void {
                        RENDERButton(id: UUID(), text: "OK", image: nil, action: okaction).foregroundColor(Color.black)
                            .frame(width: r.size.width / 2 - 20)
                        .accessibility(label: Text("Ok"))
                    }
                }.padding(20)
                    .background(Rectangle().stroke(.blue, style: StrokeStyle(lineWidth: 1.0)).background(Color.white).cornerRadius(5.0))
                .frame(width: r.size.width)
                .offset(y:offset)
            }
            .frame( height: 30)
        }
      
        .padding(.top, 20)
        .background(Rectangle().fill(Color.gray))
    }
}

// Cancel and Ok add to Localization
//

@available(iOS 16.0, *)
struct AlertPreview : PreviewProvider {
    static var previews : some View {
        Alert(text: "Sorry.  This is a information message. Please contact customer support."
              , okBtn: {
            
            }
              // optional add cancel)
              // (()->())?
              , cancelBtn: {
            
        })
    }
}
