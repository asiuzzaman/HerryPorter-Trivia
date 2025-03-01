//
//  ContentView.swift
//  HerryPorter Trivia
//
//  Created by Md. Asiuzzaman on 19/1/25.
//
import AVKit
import SwiftUI

struct ContentView: View {

    @EnvironmentObject private var store : Store
    @EnvironmentObject private var game: Game
    @State private var audioPlayer: AVAudioPlayer!
    @State private var scalePlayButton = false
    @State private var moveBackGroundImage = false
    @State private var animateViewsIn = false
    @State private var showInstructions = false
    @State private var showSettins = false
    @State private var playGame = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3, height: geo.size.height)
                    .padding(.top, 3)
                    .offset(x: moveBackGroundImage ? geo.size.width/1.1: -geo.size.width/1.1)
                    .onAppear {
                        withAnimation(.linear(duration: 60).repeatForever()) {
                            self.moveBackGroundImage.toggle()
                        }
                    }

                VStack {
                    VStack {
                        if animateViewsIn {
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
                            .transition(.move(edge: .top))
                        }
                    }
                    .animation(.easeInOut(duration: 0.7).delay(2), value: animateViewsIn )

                    Spacer()

                    VStack {
                        if animateViewsIn {
                            VStack {
                                Text("Recent Scores")
                                    .font(.title2)
                                Text("10")
                                Text("33")
                                Text("50")
                            }
                            .font(.title3)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(15)
                            .transition(.opacity)
                        }
                    }.animation(.linear(duration: 1).delay(4), value: animateViewsIn )

                    Spacer()

                    HStack {
                        Spacer()

                        VStack {
                            if animateViewsIn {
                                Button {
                                    //Show instruction screen
                                    showInstructions.toggle()
                                } label: {
                                    Image(systemName: "info.circle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .shadow(radius: 5)
                                }
                                .transition (.offset(x: -geo.size.width/4))
                                .sheet(isPresented: $showInstructions) {
                                    Instructions()
                                }
                            }
                        }.animation(.easeInOut(duration: 0.7).delay(2.7), value: animateViewsIn )

                        Spacer()
                        VStack {
                            if animateViewsIn {
                                Button {
                                    // Starting a new game
                                    playGame.toggle()
                                } label: {
                                    Text("Play")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .padding(.vertical, 7)
                                        .padding(.horizontal, 50)
                                        .background(Color.brown)
                                        .cornerRadius(20)
                                }
                                .scaleEffect(scalePlayButton ? 1.3: 1)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1.5).repeatForever()) {
                                        scalePlayButton.toggle()
                                    }
                                }
                                .transition(.offset(y: geo.size.height/3))
                                .fullScreenCover(isPresented: $playGame) {
                                    GamePlay()
                                        .environmentObject(game)
                                }
                            }
                        }.animation(.easeInOut(duration: 0.7).delay(2), value: animateViewsIn )

                        Spacer()

                        VStack {
                            if animateViewsIn {
                                Button {
                                    //Settings button
                                    showSettins.toggle()
                                } label: {
                                    Image(systemName: "gearshape.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                        .shadow(radius: 5)
                                }
                                .transition (.offset(x: geo.size.width/4))
                                .sheet(isPresented: $showSettins) {
                                    Settings()
                                        .environmentObject(store)
                                }
                            }
                        }.animation(.easeInOut(duration: 0.7).delay(2.7), value: animateViewsIn )


                        Spacer()
                    }.frame(width: geo.size.width)

                    Spacer()

                }

            }.frame(width: geo.size.width, height: geo.size.height
            )

        }.ignoresSafeArea()
            .onAppear {
                //playAudio()
                animateViewsIn = true
            }
    }

    func playAudio() {
        let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")

        audioPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
        .environmentObject(Game())
}
