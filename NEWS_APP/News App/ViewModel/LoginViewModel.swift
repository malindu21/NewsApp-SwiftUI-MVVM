//
//  LoginViewModel.swift
//  News App
//
//  Created by Malindu Chathuranga App on 2023-11-07.
//

import Foundation


final class LoginViewModel : ObservableObject{
    

    @Published  var isLoading = false
    @Published  var isSignUpTapped = false
    @Published  var loggedIn = false
    
    func getLoginDetails() {
        isSignUpTapped = true
    }
}
