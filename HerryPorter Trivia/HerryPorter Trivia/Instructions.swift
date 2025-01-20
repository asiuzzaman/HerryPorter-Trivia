//
//  Instructions.swift
//  HerryPorter Trivia
//
//  Created by Md. Asiuzzaman on 20/1/25.
//

import SwiftUI

struct Instructions: View {

    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            InfoBackgroundImage()
            VStack {
                Image("appiconwithradius")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding(.top)
                ScrollView {
                    Text("How to Play")
                        .font(.largeTitle)
                        .padding()

                    VStack(alignment: .leading) {
                        Text("Welcome to HP Trivia! In this game you will be asked random questions from the Harry Potter series. You must guess the right answer or you will lose your points 😳")
                            .padding([.horizontal, .bottom])
                        Text("Each question is worth 5 points but if you guess wrong you will lose one point.")
                            .padding([.horizontal, .bottom])
                        Text("If you struggling with question there is an option for getting hints. You can get one hint for each question.or reveal the book where the question is from. But also be aware using this also getting one point deducted from your score.")
                            .padding([.horizontal, .bottom])
                        Text("When you select the correct answer, you will be awarded and all points left for the question and increase your total score.")
                            .padding([.horizontal])

                    }.font(.title3)
                    Text("Good Luck!")
                        .font(.title)
                }
                .foregroundColor(.black)
                Button ("Done") {
                    dismiss()
                }
                .doneButton()

            }
        }
     }
}

#Preview {
    Instructions()
}
