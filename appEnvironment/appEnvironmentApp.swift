//
//  appEnvironmentApp.swift
//  appEnvironment
//
//  Created by mac on 9/30/24.
//

import SwiftUI

@main
struct appEnvironmentApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(userAuth: AuthUser())
        }
    }
}
