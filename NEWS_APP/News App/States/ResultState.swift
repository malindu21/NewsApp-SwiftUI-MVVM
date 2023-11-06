//
//  ResultState.swift
//  News App
//
//  Created by Malindu Chathuranga on 06/11/23.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [Article])
    case failed(error: Error)
}
