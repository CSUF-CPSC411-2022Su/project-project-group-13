//
//  ContentView.swift
//  FullertonEats
//
//  Created by Eric Chu on 6/8/22.
//

import SwiftUI

struct ContentView: View {
    @State private var usernameS = ""
    @State private var passwordS = ""
    @State private var emailS = ""
    
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
                    TextField("Email", text: $emailS)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                    Button("signup"){
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
