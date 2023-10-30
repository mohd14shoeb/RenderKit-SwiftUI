import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct LoadingPage : View {
    @State var pathAnimation: Bool = false
    @State var startGame: Bool = false
    @State var showGame: Bool = false
    
    let bannerOffset:CGFloat = -350.0
    
    var body: some View {
        VStack {
            GeometryReader { r in
                VStack {
                    logo()
                    
                    progressInd()
                        .opacity(startGame ? 0 : 1)
                        .animation(.easeInOut.delay(4), value: pathAnimation)
                }.frame(width: r.size.width, height: r.size.height)
         
               
                if startGame {
                    VStack {
                        let view: RENDERToolBar = RENDERToolBar()
                     
                        view.anyView
                            .opacity(showGame ? 1 : 0)
                            .animation(.easeInOut.delay(2.0).speed(0.7), value: showGame)
                            .offset(y:40)
                    }  .frame(width: r.size.width, height: r.size.height)
                }
            }
        }
      
            .background(.green.opacity(0.2))
            .background(.brown.opacity(0.3))
        .ignoresSafeArea()
        .onAppear() {
            pathAnimation = true
        }
    }
    
    @MainActor
    func validateGameStart() async -> Bool {
        if !startGame {
            //make a call for global_games_played
            return false
        }
       
        return true
    }
}
@available(iOS 16.0, *)
struct LoadingPagePreview : PreviewProvider {
    static var previews: some View {
        LoadingPage()
    }
}
@available(iOS 16.0, *)
extension LoadingPage {
    fileprivate func logo() -> some View {
        
        let logoposition1: CGSize = CGSize(width:-140, height:-268)
        let logoposition2: CGSize = CGSize(width:0, height:-20)
        let logoSize: CGSize = CGSize(width: 55, height: 55)
        let logoSize2: CGSize = CGSize(width: 0, height: 0)
        return ZStack {
            
           
            Image("logo", bundle: Bundle.main).resizable()
                .frame(width: startGame ? logoSize.width : logoSize2.width, height: startGame ? logoSize.height : logoSize2.height)
                
                .offset(startGame ? logoposition1 : logoposition2).opacity(0.8)
                .animation(.linear.speed(0.8).delay(4), value: startGame)
            
                .onAppear() {
                    startGame = true
                    
                    Task {
                        if await validateGameStart() {
                           showGame = true
                        }
                    }
                }
        }
    }
    
    fileprivate func slinky() ->  some View {
        return ForEach(0..<72) { index in
            
            Circle()
                .stroke(lineWidth: pathAnimation ? 1 : 3)
                .fill(.brown.opacity(0.5))
                .frame(width:20, height: 155)
            // HOW MUCH COIL
                .rotationEffect(pathAnimation ? Angle(degrees: Double(-5 * index)) : Angle(degrees: Double(5 * index)), anchor: .topTrailing)
                .offset(x: -10,y:60).opacity(0.4)
                .animation(.easeInOut.speed(0.2).repeatForever(autoreverses: true), value: pathAnimation)
            
        }
    }
    
    fileprivate func progressInd() -> some View {
        return ZStack {
           
           // CompassDigitalLogo()
            CircleText()
                .offset(x:-8, y: 21)
           
            
//slinky()
            
            Text("Loading...")
                .font(.headline)
                .foregroundColor(.brown.opacity(1.0)).offset(y:120)
                .opacity(pathAnimation ? 0 : 1)
                .animation(.linear.repeatForever().speed(0.9), value: pathAnimation)
        }
    }
    
    
}
