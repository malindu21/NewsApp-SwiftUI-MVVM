//
//  LoginView.swift
//  News App
//
//  Created by Malindu Chathuranga App on 2023-11-07.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""

    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        
        ZStack{
         
            if loginViewModel.loggedIn {
                NavHostView()
            }else if loginViewModel.isSignUpTapped {
               // RegisterView()
            }else{
                VStack() {
                    Spacer()
                    
                    Text("Era Biz News App")
                        .font(Font.custom("Poppins", size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                        .padding(20)
                    
                    Spacer()
                    
                    TextField("Username", text: $username)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.77, green: 0.77, blue: 0.77), lineWidth: 1))
                        .frame(width: 312)
                    
                    SecureField("Password", text: $password)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.77, green: 0.77, blue: 0.77), lineWidth: 1))
                        .frame(width: 312)
                    
                    ForgetPasswordTextField()
                    
                    Button(action:{
                        loginViewModel.loggedIn = true
                        
                    }) {
                        Text("Sign In")
                            .font(Font.custom("Poppins", size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .frame(width: 312, height: 44)
                    .background(
                        LinearGradient(
                          stops: [
                            Gradient.Stop(color: Color(red: 1, green: 0.23, blue: 0.27), location: 0.00),
                            Gradient.Stop(color: Color(red: 1, green: 0.5, blue: 0.53), location: 1.00),
                          ],
                          startPoint: UnitPoint(x: 0, y: 0),
                          endPoint: UnitPoint(x: 1.07, y: 1.65)
                        )
                    )
                    .cornerRadius(8)
                    
                    TextViewsForOnboarding(vm: loginViewModel)
            
                    Spacer()
              
                }
            }
        } .preferredColorScheme(.light)
    }
}

struct TextViewsForOnboarding: View {
    

    @ObservedObject var vm: LoginViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Don’t have an account yet?")
                .font(Font.custom("Poppins", size: 14))
                .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
            
            Text("Sign Up")
                .font(Font.custom("Poppins", size: 14).weight(.semibold))
                .foregroundColor(Color(red: 0.77, green: 0.05, blue: 0.26))
                .onTapGesture {
                    print("hello")
                    vm.isSignUpTapped = true
                }
            
            Text("Continue as a Guest")
                .font(Font.custom("Poppins", size: 14))
                .foregroundColor(.black)
                .onTapGesture {
                    vm.loggedIn = true
                }
         
        }
    }
}

struct ForgetPasswordTextField: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Forgot Your Password ?")
                .font(Font.custom("Poppins", size: 12).weight(.medium))
                .foregroundColor(Color(red: 0.77, green: 0.05, blue: 0.26))
        }
        .frame(width: 312, height: 52)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
            LoginView()
    }
}
