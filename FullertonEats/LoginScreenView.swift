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
    @State var showingErrorMessage = false
    @State var errorMessage = ""
    @State var isLoginSucessful = false
    @StateObject var user = User()
    
    var userLoader = UserLoader()
    
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
                        
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    NavigationLink(destination: Navigator(user: user), isActive: $isLoginSucessful) {
                        EmptyView()
                    }
                
                    Button("Login") {
                        if !username.isEmpty, !password.isEmpty, let loadedUser = userLoader.loadUser() {
                            if loadedUser.username == username, loadedUser.password == password {
                                isLoginSucessful = true
                                user.assign(loadedUser)
                            } else {
                                showingErrorMessage.toggle()
                                errorMessage = "Incorrect username or password!"
                            }
                        } else {
                            showingErrorMessage.toggle()
                            errorMessage = "Username or password is empty!"
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                LoginError(isActive: $showingErrorMessage, errorMessage: $errorMessage)
            }
        }
        .hiddenNavigationBarStyle()
    }
}

struct LoginError: View {
    @Binding var isActive: Bool
    @Binding var errorMessage: String
    
    var body: some View {
        ZStack {
            if isActive {
                VStack(spacing: 0) {
                    Text(errorMessage)
                        .frame(maxWidth: .infinity)
                        .frame(height: 100, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)

                    Button(action: {
                        isActive = false
                    }) {
                        Text("Ok")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50, alignment: .center)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(PlainButtonStyle())
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
