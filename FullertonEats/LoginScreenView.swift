//
//  LoginScreenView.swift
//  FullertonEats
//
//  Created by csuftitan on 6/18/22.
//

import Foundation
import SwiftUI

struct LoginScreenView: View {
    @SceneStorage("username") var username = ""
    @SceneStorage("password") var password = ""
    @StateObject var user = User()
    @State var loginNotify: Bool = false
    var userLoader = UserLoader()
    
    init() {
        if let loaderUser = userLoader.loadUser() {
            user.username = loaderUser.username
            user.password = loaderUser.password
            user.favoritedEvents = loaderUser.favoritedEvents
            user.myEvents = loaderUser.myEvents
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundDesign()
                
                VStack {
                    Text("FullertonEats")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    Text("Login")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                        
                    TextField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                
                    Button("login") {
                        if user.username==username, user.password==password {
                            loginNotify.toggle()
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                Login_Notify(login: $loginNotify)
            }
        }
        .navigationBarHidden(true)
    }
}
    
struct Login_Notify: View {
    @Binding var login: Bool
    var body: some View {
        ZStack {
            if login {
                VStack(spacing: 0) {
                    Text("Success")
                        .frame(maxWidth: .infinity)
                        .frame(height: 100, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)

                    NavigationLink(destination: ContentView()) {
                        Text("Homepage")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50, alignment: .center)
                            .foregroundColor(.white)
                    }
                    .background(Color.CSUFBlue())
                }
                .frame(maxWidth: 300)
                .background(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            }
        }
    }
}
    
struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginScreenView()
        }
    }
}
