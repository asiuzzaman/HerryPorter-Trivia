//
//  ContentView.swift
//  HerryPorter Trivia
//
//  Created by Md. Asiuzzaman on 19/1/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .padding(.top, 3)

                VStack {
                    VStack {
                        Image(systemName: "bolt.fill")
                            .font(.largeTitle)
                            .imageScale(.large)
                        Text("HP")
                            .font(.custom(Constants.hpFont, size: 70))
                            .padding(.bottom, -50)
                        Text("Trivia")
                            .font(.custom(Constants.hpFont, size: 60))
                    }
                    .padding(.top, 70)
                    Spacer()

                    VStack {
                        Text("Recent Scores")
                            .font(.title2)
                        Text("33")
                        Text("33")
                        Text("50")
                    }
                    .font(.title3)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(15)

                    Spacer()

                    HStack {
                        Spacer()
                        Button {
                            //Show instruction screen
                        } label: {
                            Image(systemName: "info.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                        Spacer()
                        Button {
                            // Starting a new game
                        } label: {
                            Text("Play")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 50)
                            .background(Color.brown)
                            .cornerRadius(20)
                        }

                        Spacer()
                        Button {
                            //Settings button
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(radius: 5)
                        }
                        Spacer()
                    }.frame(width: geo.size.width)

                    Spacer()

                }

            }.frame(width: geo.size.width, height: geo.size.height
            )

        }.ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
