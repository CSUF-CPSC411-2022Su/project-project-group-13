//
//  foodProvider_User.swift
//  FullertonEats
//
//  Created by csuftitan on 6/8/22.
//
import SwiftUI
import Foundation

struct foodProvider_user: View {
    
    var body: some View {
        
        VStack (spacing: 8.0){
            Text("Your Address :")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.0, green: 0.15294117647058825, blue: 0.2980392156862745))
                .multilineTextAlignment(.leading)
            
            
            TextField("Please enter your address ", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .frame(height: 90.0)
            
            //search box shap
                .overlay(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(.orange, lineWidth: 2)
                )
            
            
            Label("Search", systemImage: "magnifyingglass.circle.fill")
                .imageScale(.large)
                .font(.headline)
                .foregroundColor(Color(red: 0.8823529411764706, green: 0.4392156862745098, blue: 0.0))
                .multilineTextAlignment(.leading)
            
        }
        
        .padding(.all, 25.0)
        .shadow(color: .orange, radius: 30, x: -10, y: -10)
        .frame(height: 200.0)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 0.661, saturation: 0.064, brightness: 0.763, opacity: 0.12)/*@END_MENU_TOKEN@*/)
        .cornerRadius(/*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
        .offset(y:-100)
        
        // second Vstack
    }
    
}
