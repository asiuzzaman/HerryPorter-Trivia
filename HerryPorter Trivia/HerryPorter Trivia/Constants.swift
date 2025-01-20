//
//  Constants.swift
//  HerryPorter Trivia
//
//  Created by Md. Asiuzzaman on 19/1/25.
//

import SwiftUI

enum Constants {
    static let hpFont = "PartyLetPlain"
}

struct InfoBackgroundImage: View {
    var body: some View {
        Image("parchment")
            .resizable()
            .ignoresSafeArea()
            .background(.brown)
    }
}

extension Button {
    func doneButton() -> some View {
        self
            .font(.largeTitle)
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(Color.brown)
            .foregroundColor(.white)
    }
}

