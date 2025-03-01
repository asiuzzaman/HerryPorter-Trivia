//
//  Settings.swift
//  HerryPorter Trivia
//
//  Created by Md. Asiuzzaman on 30/1/25.
//

import SwiftUI



struct Settings: View {
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject private var store: Store

    var body: some View {
        ZStack {
            InfoBackgroundImage()
            VStack {
                Text("Which book would you like to see question from?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                ScrollView {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(0..<7) { index in

                            if store.bookStatus[index] == .active || (store.bookStatus[index] == .locked && store.purchasedIDs.contains("hp\(index+1)")) {
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(index+1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundColor(.green)
                                        .shadow(radius: 1)
                                        .padding(3)
                                }
                                .task {
                                    store.bookStatus[index] = .active
                                }
                                .onTapGesture {
                                    store.bookStatus[index] = .inactive
                                }
                            }
                            else if store.bookStatus[index] == .inactive {
                                ZStack(alignment: .bottomTrailing) {
                                    Image("hp\(index+1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                        .overlay(Rectangle().opacity(0.33))
                                    Image(systemName: "circle")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundColor(.green.opacity(0.5))
                                        .shadow(radius: 1)
                                        .padding(3)
                                }
                                .onTapGesture {
                                    store.bookStatus[index] = .active
                                }

                            } else {
                                ZStack {
                                    Image("hp\(index+1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                        .overlay(Rectangle().opacity(0.75))
                                    Image(systemName: "lock.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .shadow(color: .white.opacity(0.75), radius: 3)
                                        .padding(3)
                                }
                                .onTapGesture {
                                    let product = store.products[index - 3]
                                    Task {
                                        await store.purchase(product: product)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }

                Button ("Done") {
                    dismiss()
                }.doneButton()
            }
        }
    }
}

#Preview {
    Settings()
        .environmentObject(Store())
}
