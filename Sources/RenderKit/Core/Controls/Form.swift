import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct RENDERForm: View {
    // AppStorage temp for demo
    @AppStorage("loginName") private var loginName: String = ""
    @AppStorage("password") private var password: String = ""
    
    @State  var authenticated: Bool = false
    @ObservedObject var data: SampleData
    var body: some View {
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
                            let login = LoginRequest(loginName: $loginName.wrappedValue, password: $password.wrappedValue )
                            //URL with LoginRequest
                            if (loginName == "Darren" && password == "HireME"){
                                self.authenticated.toggle()
                            }
              
                        }, label: {
                            Text("Login").frame(width: reader.size.width, height:20).padding(10)
                        })
                        .contentShape(Rectangle())
                        .background(Color.blue.opacity(0.2))
                        .frame(width: reader.size.width, height:20)
                        .padding(.top, 10)
                    }
                    
                } else {
                    WelcomeText(data: data).onTapGesture {
                        self.authenticated.toggle()
                    }
                }
            }.frame(height: 400)
        }
    
}

class LoginRequest: Codable {
    var loginName: String?
    var password: String?
    
    init(loginName: String, password: String){
        self.loginName = loginName
        self.password = password
    }
}
