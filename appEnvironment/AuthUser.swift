//
//  AuthUser.swift
//  appEnvironment
//
//  Created by mac on 9/30/24.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration

class AuthUser:ObservableObject {
    //1. membuat didchange
    var didChange = PassthroughSubject<AuthUser, Never>()
    
    //2. rubah state
    @Published var isLoggedIn: Bool = false{
        didSet{
            didChange.send(self)
        }
    }
    
    // Print error message
    @Published var isCorrect: Bool = true
    
    //3. fungsi cek login
    func checkLogin(password: String, username: String){
        guard let url = URL(string: "https://dummyjson.com/auth/login") else{
            return
        }
        
        let body:[String:String] = ["password": password, "username": username]
        
        guard let finalBody = try? JSONEncoder().encode(body) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {return}
            
            //5. decode data
            let result = try? JSONDecoder().decode(UserLogin.self, from: data)
            
            if let result = result{
                DispatchQueue.main.async {
                    if result.accessToken != "" {
                        self.isLoggedIn = true
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.isCorrect = false
                }
            }
        }.resume()
    }
}
