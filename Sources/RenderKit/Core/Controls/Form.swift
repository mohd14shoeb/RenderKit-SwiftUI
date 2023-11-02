import Foundation
import SwiftUI

@available(iOS 16.0, *)
struct RENDERForm: View {
    // AppStorage temp for demo
    //@AppStorage("loginName") private var loginName: String = ""
    //@AppStorage("password") private var password: String = ""
    @StateObject var loginModel = LoginModel(loginName: "",
                                             password: "",
                                             rememberMe: false)

    @State  var authenticated: Bool = false
    @ObservedObject var data: SampleData
    var body: some View {
            GeometryReader() { reader in
                if !$authenticated.wrappedValue {
                    VStack {
                        TextField("Login", text: $loginModel.loginName)
                            .background(Color.blue.opacity(0.2)).frame(height:20)
                            .padding(.bottom, 10)
                        TextField("Password", text: $loginModel.password)
                            .background(Color.blue.opacity(0.2)).frame(height:20)
                            .padding(.bottom, 10)
                        Button(action: {
                            Task {
                                //URL with LoginRequest
                                if ($loginModel.loginName.wrappedValue == "Darren" && $loginModel.password.wrappedValue == "HireME"){
                                    self.authenticated.toggle()
                                }
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

class LoginModel: ObservableObject {
    @Published var loginName: String
    @Published var password: String
    @Published var rememberMe: Bool
    
    init(loginName: String, password: String, rememberMe: Bool){
        self.loginName = loginName
        self.password = password
        self.rememberMe = rememberMe
    }
}
