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
    @State var showingErrorMessage = false
    @State var errorMessage = ""
    @State var isLoginSucessful = false
    
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
                    .padding(.vertical, 5)
                
                    Button("Login") {
                        if !username.isEmpty, !password.isEmpty {
                            if let loadedUser = userLoader.loadUser() {
                                // Retrieve login credentials from file
                                if loadedUser.username == username, loadedUser.password == password {
                                    isLoginSucessful = true
                                    user.assign(loadedUser)
                                } else {
                                    showingErrorMessage.toggle()
                                    errorMessage = "Incorrect username or password!"
                                }
                            } else {
                                showingErrorMessage.toggle()
                                errorMessage = "The account does not exist!"
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
        .environmentObject(user)
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
