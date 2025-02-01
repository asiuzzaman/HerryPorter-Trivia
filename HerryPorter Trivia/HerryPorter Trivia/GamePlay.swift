//
//  GamePlay.swift
//  HerryPorter Trivia
//
//  Created by Md. Asiuzzaman on 1/2/25.
//

import SwiftUI

struct GamePlay: View {
    @State private var animationViewsIn = false
    @State private var tappedCorrectAnswer = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                //Text("Hello work")
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height * 1.05)
                    .overlay(Rectangle().foregroundStyle(.black.opacity(0.8)))

                VStack {
                    // MARK: End Game
                    HStack {
                        Button("End Game") {
                            // TODO: End the game
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))
                        Spacer()
                        Text("Score: 0")
                    }
                    .padding()
                    .padding(.vertical, 30)

                    // MARK: Questions
                    VStack {
                        if animationViewsIn {
                            Text("Who is harry porter?")
                                .font(.custom(Constants.hpFont, size: 50))
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }
                    .animation(.easeInOut(duration: 2), value: animationViewsIn)

                    Spacer()

                    // MARK: Hints
                    HStack {
                        VStack {
                            if animationViewsIn {
                                Image(systemName: "questionmark.app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundStyle(.cyan)
                                    .rotationEffect(.degrees(-15))
                                    .padding()
                                    .padding(.leading, 20)
                                    .transition (.offset(x: -geo.size.width/2))
                            }
                        }
                        .animation(.easeInOut(duration: 1.5).delay(2), value: animationViewsIn)

                        Spacer()
                        VStack {
                            if animationViewsIn {
                                Image(systemName: "book.closed")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                    .foregroundStyle(.black)
                                    .frame(width: 100, height: 100)
                                    .background(.cyan)
                                    .cornerRadius(20)
                                    .rotationEffect(.degrees(15))
                                    .padding()
                                    .padding(.trailing, 20)
                                    .transition (.offset(x: geo.size.width/2))
                            }
                        }
                        .animation(.easeInOut(duration: 1.5).delay(2), value: animationViewsIn)
                    }
                    .padding()

                    // MARK: Answers
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(1..<5) { i in
                            VStack {
                                if animationViewsIn {
                                    Text("Answer: \(i)")
                                        .multilineTextAlignment(.center)
                                        .minimumScaleFactor(0.5)
                                        .padding(10)
                                        .frame(width: geo.size.width/2.15, height: 80)
                                        .background(.green.opacity(0.5))
                                        .cornerRadius(25)
                                        .transition(.scale)
                                }
                            }
                            .animation(.easeOut(duration: 1).delay(1.5), value: animationViewsIn)
                        }
                    }
                    Spacer()
                }
                .frame(width: geo.size.width, height: geo.size.height)
                .foregroundStyle(.white)

                VStack {
                    Spacer()

                    VStack {
                        if tappedCorrectAnswer {
                            Text("5")
                                .font(.largeTitle)
                                .padding(50)
                                .transition(.offset(y: -geo.size.height/4))
                        }
                    }
                    .animation(.easeInOut(duration: 1).delay(2), value: tappedCorrectAnswer)

                    Spacer()
                    VStack {
                        if tappedCorrectAnswer {
                            Text("Brilliant!")
                                .font(.custom(Constants.hpFont, size: 60))
                                .transition(.scale.combined(with: .offset(y: -geo.size.height/2)))
                        }
                    }.animation(.easeInOut(duration: 1).delay(1), value: tappedCorrectAnswer)

                    Spacer()

                    Text("Answer 1")
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .frame(width: geo.size.width/2.15, height: 80)
                        .background(.green.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .scaleEffect(2)

                    Group {
                        Spacer()
                        Spacer()
                    }

                    VStack {
                        if tappedCorrectAnswer {
                            Button("Next Question") {
                                // TODO: Reset level for next question
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.blue.opacity(0.5))
                            .font(.largeTitle)
                            .transition(.offset(y: geo.size.height/3))
                        }
                    }
                    .animation(.easeInOut(duration: 2).delay(2), value: tappedCorrectAnswer)

                    Group {
                        Spacer()
                        Spacer()
                    }

                }
                .foregroundStyle(.white)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear() {
           // animationViewsIn = true
            tappedCorrectAnswer = true
        }
    }
}

#Preview {
    VStack {
        GamePlay()
    }
}
