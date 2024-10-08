//
//  Model.swift
//  appEnvironment
//
//  Created by mac on 10/2/24.
//

import Foundation
import SwiftUI

// 4. buat model

struct UserLogin:Codable, Identifiable {
    var id: String = UUID().uuidString
    let message: String
    let accessToken: String
    let refreshToken: Int
    //let currUser: Int
    let firstName: String
    let lastName: String
    //let isverified: Bool
}
