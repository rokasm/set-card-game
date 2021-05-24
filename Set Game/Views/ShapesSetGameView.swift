//
//  ContentView.swift
//  Set Game
//
//  Created by Rokas Mikelionis on 2021-03-07.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

struct ShapesSetGameView: View {
    @ObservedObject var viewModel = ShapesSetGame()
    @AppStorage(wrappedValue: false, "onboardingVisible") var onboardingVisible
    
    var body: some View {
        ZStack {
            Rectangle().fill(
                LinearGradient(gradient: Gradient(
                                colors: [statusBackground, Color("Background2")]),
                               startPoint: .topTrailing,
                               endPoint: .bottomLeading))
                .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack() {
                        Spacer()
                            .frame(width: 50)
                       VStack() {
                            Text(status)
                                .font(.system(size: 27, design: .rounded))
                                .fontWeight(.black)
                                .foregroundColor(Color("TextColorTitle1"))
                                .shadow(color: Color.black.opacity(0.25), radius: 0.1, x: -1 , y: 1)
                                .transition(.opacity)
                            Text("Score: \(viewModel.score)")
                                .font(.system(size: 21, design: .rounded))
                                .foregroundColor(Color("TextDark"))
                        }
                       .frame(maxWidth: .infinity)
                        Button(action: {
                            onboardingVisible.toggle()
                        }) {
                            Image(systemName: "questionmark.square.dashed")
                                .font(.system(size: 36, design: .rounded))
                                .foregroundColor(Color("TextColorTitle1").opacity(0.75))
                                .shadow(color: Color.black.opacity(0.05), radius: 0.1, x: -1 , y: 1)
                        }
                        .frame(width: 36)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                        .sheet(isPresented: $onboardingVisible) {
                            OnboardingView(action: self.viewModel.newGame)
                                }
                    }.frame(maxWidth: .infinity)
                    Grid(viewModel.dealtCards) { card in
                        CardView(card: card)
                            .transition(AnyTransition.offset(randomLocation()))
                            .onTapGesture {
                                withAnimation(cardChooseAnimation) {
                                    self.viewModel.chooseCard(card: card)
                                }
                            }
                    }
                    HStack {
                        Button(action: {
                            withAnimation(baseAnimation){
                                viewModel.deal3cards()
                            }
                        }){
                            Text("Deal 3 More Cards")
                                .font(.system(size: 21, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color("TextColorTitle1"))
                        }
                        Spacer()
                        Button(action: {
                            withAnimation(baseAnimation){
                                viewModel.newGame()
                            }
                        }) {
                            Text("New Game")
                                .font(.system(size: 21, design: .rounded))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("TextColorTitle1"))
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                    .shadow(color: Color.black.opacity(0.25), radius: 0.1, x: -1 , y: 1)
                    .transition(.opacity)
                }
        }
        .onAppear() {
            if !onboardingVisible {
                withAnimation(baseAnimation){
                    viewModel.newGame()
                }
            }
        }
    }
    
    var status: String {
        switch viewModel.state {
        case .match:
            return "Set!"
        case .noMatch:
            return "No match"
        case .selectCard:
            return "Select Cards"
        }
    }
    var statusBackground: Color {
        switch viewModel.state {
        case .match:
            return Color("BackgroundMatch")
        case .noMatch:
            return Color("CardColor3Reflection")
        case .selectCard:
            return Color("Background1")
        }
    }
    var backgroundOpacity: Double {
        switch viewModel.state {
        case .match:
            return 1
        case .noMatch:
            return 1
        case .selectCard:
            return 0
        }
    }
    let baseAnimation: Animation = Animation.easeInOut.speed(0.25)
    let cardChooseAnimation: Animation = Animation.easeInOut.speed(0.75)
    func randomLocation() -> CGSize {
        CGSize(width: Double.random(in: -1000 ... -400), height: Double.random(in: -1000 ... -400))
    }
}

struct ShapesSetGameView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesSetGameView()
    }
}

