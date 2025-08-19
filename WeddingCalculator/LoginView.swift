//
//  LoginView.swift
//  WeddingCalculator
//
//  Created by Bartosz Jurczyk on 14/08/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack(spacing: 30) {
            // App title
            VStack(spacing: 8) {
                Image(systemName: "app.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.red)
                Text("EventPlanner")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding(.top, 60)
            
            // Text fields
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            // Login button
            Button(action: {
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // Divider with "or"
            HStack {
                Rectangle().frame(height: 1).foregroundColor(Color(.systemGray4))
                Text("OR")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                Rectangle().frame(height: 1).foregroundColor(Color(.systemGray4))
            }
            .padding(.horizontal)
            
            // Google login button
            Button(action: {
            }) {
                HStack {
                    Image(systemName: "globe")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Continue with Google")
                        .font(.headline)
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .shadow(color: Color(.systemGray3), radius: 2, x: 0, y: 2)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(Color(.systemBackground))
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginView()
}

