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
    @State var showingLoginSuccess = false
    @State var showingErrorMessage = false
    @State var errorMessage = ""
    
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
                        
                    TextField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                
                    Button("Login") {
                        // loading decodedUser to user
                        if let loadedUser = userLoader.loadUser() {
                            user.assign(loadedUser)
                        }
                        
                        if !username.isEmpty, !password.isEmpty {
                            if user.username == username, user.password == password {
                                showingLoginSuccess.toggle()
                            } else {
                                showingErrorMessage.toggle()
                                errorMessage = "Incorrect username or password!"
                            }
                        } else {
                            showingErrorMessage.toggle()
                            errorMessage = "Username or password is empty!"
                        }
                    }
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
                LoginSuccess(login: $showingLoginSuccess)
                LoginError(isActive: $showingErrorMessage, errorMessage: $errorMessage)
            }
        }
        .environmentObject(user)
        .hiddenNavigationBarStyle()
    }
}
    
struct LoginSuccess: View {
    @Binding var login: Bool
    var body: some View {
        ZStack {
            if login {
                VStack(spacing: 0) {
                    Text("Success!")
                        .frame(maxWidth: .infinity)
                        .frame(height: 100, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)

                    NavigationLink(destination: Navigator()) {
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

// Created by Eric Chu
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
