//
//  LoginScreenView.swift
//  FullertonEats
//
//  Created by csuftitan on 6/18/22.
//

import Foundation
import SwiftUI

struct LoginScreenView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white)
                Circle()
                    .scale(1.35)
                    .foregroundColor(.orange)
                
                VStack{
                    Text("FullertonEats")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    Text("login")
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
                    Button("login"){
                        //authenticate user if they have an account set up
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
            .navigationBarHidden(true)
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
