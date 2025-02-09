//
//  GamePlay.swift
//  HerryPorter Trivia
//
//  Created by Md. Asiuzzaman on 1/2/25.
//
import AVKit
import SwiftUI

struct GamePlay: View {
    @Environment(\.dismiss) private var dismiss
    @Namespace private var namespace
    @State private var animationViewsIn = false
    @State private var tappedCorrectAnswer = false
    @State private var hintWiggle = false
    @State private var scaleNextButton = false
    @State private var movePointsToScore = false
    @State private var revealHint = false
    @State private var revealBook = false
    @State private var musicPlayer: AVAudioPlayer!
    @State private var sfxPlayer: AVAudioPlayer!


   // @State private var tappedWrongAnswer = false
    @State private var wrongAnswerTapped: [Int] = []

    let tempAnswers = [false, false, false, true]

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
                            dismiss()
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
                                .opacity(tappedCorrectAnswer ? 0.1 : 1)
                        }
                    }
                    .animation(.easeInOut(duration: animationViewsIn ? 2 : 0), value: animationViewsIn)

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
                                    .rotationEffect(.degrees(hintWiggle ? -13: -17))
                                    .padding()
                                    .padding(.leading, 20)
                                    .transition (.offset(x: -geo.size.width/2))
                                    .onAppear {
                                        withAnimation(.easeInOut(duration: 0.1).repeatCount(9).delay(2).repeatForever()) {
                                            hintWiggle = true
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation(.easeOut(duration: 1)) {
                                            revealHint = true
                                            playFlipSound()
                                        }

                                    }
                                    .rotation3DEffect(.degrees(revealHint ? 1440: 0), axis: (x: 0, y: 1, z: 0))
                                    .scaleEffect(revealHint ? 5: 1)
                                    .opacity(revealHint ? 0: 1)
                                    .offset(x: revealHint ? geo.size.width/2: 0)
                                    .overlay (
                                        Text("The boy who")
                                            .padding()
                                            .minimumScaleFactor(0.5)
                                            .multilineTextAlignment(.center)
                                            .opacity(revealHint ? 1: 0)
                                            .scaleEffect(revealHint ? 1.33: 1)
                                    )
                                    .opacity(tappedCorrectAnswer ? 0 : 1)
                                    .disabled(tappedCorrectAnswer)
                            }
                        }
                        .animation(.easeInOut(duration: animationViewsIn ? 1.5: 0).delay(animationViewsIn ? 2: 0), value: animationViewsIn)

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
                                    .rotationEffect(.degrees( hintWiggle ? 13: 17 ))
                                    .padding()
                                    .padding(.trailing, 20)
                                    .transition (.offset(x: geo.size.width/2))
                                    .onAppear {
                                        withAnimation(.easeInOut(duration: 0.1).repeatCount(9).delay(2).repeatForever()) {
                                            hintWiggle = true
                                        }
                                    }
                                    .onTapGesture {
                                        withAnimation(.easeOut(duration: 1)) {
                                            revealBook = true
                                            playFlipSound()
                                        }

                                    }
                                    .rotation3DEffect(.degrees(revealBook ? 1440: 0), axis: (x: 0, y: 1, z: 0))
                                    .scaleEffect(revealBook ? 5: 1)
                                    .opacity(revealBook ? 0: 1)
                                    .offset(x: revealBook ? -geo.size.width/2: 0)
                                    .overlay (
                                        Image("hp1")
                                            .resizable()
                                            .scaledToFit()
                                            .padding()
                                            .opacity(revealBook ? 1: 0)
                                            .scaleEffect(revealBook ? 1.33: 1)
                                    )
                                    .opacity(tappedCorrectAnswer ? 0 : 1)
                                    .disabled(tappedCorrectAnswer)

                            }
                        }
                        .animation(.easeInOut(duration: animationViewsIn ? 1.5: 0).delay(animationViewsIn ? 2: 0), value: animationViewsIn)
                    }
                    .padding()

                    // MARK: Answers
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(1..<5) { i in
                            if tempAnswers[i-1] {
                                VStack {
                                    if animationViewsIn {
                                        if tappedCorrectAnswer == false {
                                            Text("Answer: \(i)")
                                                .multilineTextAlignment(.center)
                                                .minimumScaleFactor(0.5)
                                                .padding(10)
                                                .frame(width: geo.size.width/2.15, height: 80)
                                                .background(.green.opacity(0.5))
                                                .cornerRadius(25)
                                                .transition(.asymmetric(insertion: .scale, removal: .scale(scale: 5).combined(with: .opacity.animation(.easeOut(duration: 0.5)))))
                                                .matchedGeometryEffect(id: "answer", in: namespace)
                                                .onTapGesture {
                                                    withAnimation(.easeOut(duration: 1)) {
                                                        tappedCorrectAnswer = true
                                                        playCorrectSound()
                                                }
                                             }
                                        }
                                    }
                                }
                                .animation(.easeOut(duration: animationViewsIn ? 1: 0).delay( animationViewsIn ?  1.5: 0), value: animationViewsIn)
                            } else {
                                VStack {
                                    if animationViewsIn {
                                        Text("Answer: \(i)")
                                            .multilineTextAlignment(.center)
                                            .minimumScaleFactor(0.5)
                                            .padding(10)
                                            .frame(width: geo.size.width/2.15, height: 80)
                                            .background( wrongAnswerTapped.contains(i) ? .red.opacity(0.5): .green.opacity(0.5))
                                            .cornerRadius(25)
                                            .transition(.scale)
                                            .onTapGesture {
                                                withAnimation(.easeOut(duration: 1)) {
                                                    playWrongSound()
                                                    wrongAnswerTapped.append(i);
                                                    giveWrongFeedback()
                                                }
                                            }
                                            .scaleEffect(wrongAnswerTapped.contains(i) ? 0.8: 1)
                                            .disabled(wrongAnswerTapped.contains(i) || tappedCorrectAnswer )
                                            .opacity(tappedCorrectAnswer ? 0 : 1)
                                            .disabled(tappedCorrectAnswer)
                                    }
                                }
                                .animation(.easeOut(duration: animationViewsIn ?  1: 0).delay(animationViewsIn ? 1.5: 0), value: animationViewsIn)
                            }
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
                                .offset(x: movePointsToScore ? geo.size.width/2.3 : 0, y: movePointsToScore ? -geo.size.height/13 : 0 )
                                .opacity(movePointsToScore ? 0: 1)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 1.5).delay(3)) {
                                        movePointsToScore = true
                                    }
                                }

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
                    }.animation(.easeInOut(duration: tappedCorrectAnswer ?  1: 0).delay(tappedCorrectAnswer ? 1: 0), value: tappedCorrectAnswer)

                    Spacer()
                    if tappedCorrectAnswer {
                        Text("Answer 1")
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .frame(width: geo.size.width/2.15, height: 80)
                            .background(.green.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .scaleEffect(2)
                            .matchedGeometryEffect(id: "answer", in: namespace)
                    }

                    Group {
                        Spacer()
                        Spacer()
                    }

                    VStack {
                        if tappedCorrectAnswer {
                            Button("Next Question") {
                                // TODO: Reset level for next question
                                animationViewsIn = false
                                tappedCorrectAnswer = false
                                revealBook = false
                                revealHint = false
                                movePointsToScore = false
                                wrongAnswerTapped = []

                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    animationViewsIn = true
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.blue.opacity(0.5))
                            .font(.largeTitle)
                            .transition(.offset(y: geo.size.height/3))
                            .scaleEffect(scaleNextButton ? 1.3: 1)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1.5).repeatForever()) {
                                    scaleNextButton.toggle()
                                }
                            }
                        }
                    }
                    .animation(.easeInOut(duration: tappedCorrectAnswer ? 2: 0).delay(tappedCorrectAnswer ? 2.7: 0), value: tappedCorrectAnswer)

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
            animationViewsIn = true
            //tappedCorrectAnswer = true
            //playMusic()
        }
    }

    private func playFlipSound() {
        let sound = Bundle.main.path(forResource: "page-flip", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        sfxPlayer.volume = 0.15
        sfxPlayer.play()
    }

    private func playWrongSound() {
        let sound = Bundle.main.path(forResource: "negative-beeps", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        sfxPlayer.volume = 0.15
        sfxPlayer.play()
    }

    private func playCorrectSound() {
        let sound = Bundle.main.path(forResource: "magic-wand", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        sfxPlayer.volume = 0.15
        sfxPlayer.play()
    }

    private func giveWrongFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    func playMusic() {
        let songs = ["let-the-mystery-unfold", "spellcraft", "hiding-place-in-the-forest", "deep-in-the-dell", "magic-in-the-air"]
        let i = Int.random(in: 0..<songs.count)
        let sound = Bundle.main.path(forResource: songs[i], ofType: "mp3")
        musicPlayer = try! AVAudioPlayer(contentsOf: URL(filePath: sound!))
        musicPlayer.volume = 0.08
        musicPlayer.numberOfLoops = -1
        musicPlayer.play()
    }
}

#Preview {
    VStack {
        GamePlay()
    }
}
