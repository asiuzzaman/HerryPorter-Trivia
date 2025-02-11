//
//  HerryPorter_TriviaApp.swift
//  HerryPorter Trivia
//
//  Created by Md. Asiuzzaman on 19/1/25.
//

import SwiftUI

@main
struct HerryPorter_TriviaApp: App {

    @StateObject private var store = Store()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
