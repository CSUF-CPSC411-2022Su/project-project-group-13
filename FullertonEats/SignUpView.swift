//
//  SignUpView.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/8/22.
//

import Foundation
import SwiftUI

struct SignUpView: View {
    @SceneStorage("usernameS") private var usernameS: String = ""
    @SceneStorage("passwordS") private var passwordS: String = ""
    @EnvironmentObject var user: User
    @State var popUpS: Bool = false

    var loader = UserLoader()

    var body: some View {
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
                SecureField("Password", text: $passwordS)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                Button("signup") {
                    if !usernameS.isEmpty, !passwordS.isEmpty {
                        user.username = usernameS
                        user.password = passwordS
                        loader.saveUser(user: user)
                        popUpS.toggle()
                    }
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
            }

            SignUp_Notify(signUpPop: $popUpS)
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

                    Button(action: {
                        signUpPop = false
                    }) {
                        Text("Ok")
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
