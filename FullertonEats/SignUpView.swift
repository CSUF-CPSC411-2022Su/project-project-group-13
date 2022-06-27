//
//  SignUpView.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/8/22.
//

import Foundation
import SwiftUI

struct SignUpView: View {
    @State private var usernameS: String = ""
    @State private var passwordS: String = ""
    var loader = UserLoader()
    @StateObject var user = User()
    @State var popUpS: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundDesign()
                VStack {
                    Text("FullertonEats")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text: $usernameS)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                    TextField("Password", text: $passwordS)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                    Button("signup") { // Implement file creation & write
                        self.usernameS = usernameS
                        self.passwordS = passwordS
                        loader.saveUser(user: user)
                        popUpS.toggle()
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                SignUp_Notify(signUpPop: $popUpS)
            }
            .navigationBarHidden(true)
        }
    }
}

struct SignUp_Notify: View {
    @Binding var signUpPop: Bool
    var body: some View {
        ZStack {
            if signUpPop {
                VStack(spacing: 0) {
                    Text("Account Created")
                        .frame(maxWidth: .infinity)
                        .frame(height: 100, alignment: .center)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)

                    NavigationLink(destination: LoginScreenView()) {
                        Text("Login")
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
