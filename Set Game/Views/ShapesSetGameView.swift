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
    @State var gameOver: Bool = false
    var score: Int = 0
    var animatableData: Int {
        get { score }
        set { score = newValue }
    }
        
    var body: some View {
        let score: Int = viewModel.score
        ZStack {
            Rectangle().fill(
                LinearGradient(gradient: Gradient(
                                colors: [statusBackground, Color("Background1")]),
                               startPoint: .topTrailing,
                               endPoint: .bottomLeading))
                .edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
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
                                .id("id" + status)
                                .transition(.slide)
                                .frame(width: geometry.size.width - 36 - 36 - 32)
                                .padding(.top, 10)
                            HStack {
                                Text("Score: ")
                                    .font(.system(size: 21, design: .rounded))
                                    .foregroundColor(Color("TextDark"))
                                Text("\(score)")
                                    .font(.system(size: 21, design: .rounded))
                                    .foregroundColor(Color("TextDark"))
                                    .id("id\(score)")
                                    .animation(cardChooseAnimation)
                                    .transition(.move(edge: .top))
                            }
                        }
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
                            OnboardingView(action: viewModel.newGame)
                        }
                    }
                    Spacer()
                    AspectVGrid(items: viewModel.dealtCards, aspectRatio: 3/4, content: { card in
                        CardView(card: card)
                            .transition(AnyTransition.offset(randomLocation()))
                            .onTapGesture {
                                withAnimation(cardChooseAnimation) {
                                    self.viewModel.chooseCard(card: card)
                                }
                            }
                    })
                    .padding(.horizontal, 35)
                    Spacer()
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
                    .onChange(of: viewModel.state) { newValue in
                        if  viewModel.state == .gameOver {
                            gameOver = true
                        }
                    }
                    .alert(isPresented: $gameOver) {
                        Alert(title: Text("No more possible sets"), message: Text("Your score: \(viewModel.score)"), dismissButton: .default(Text("New Game"), action: alertAction ))
                    }
                }
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
    
    func alertAction() {
        withAnimation(baseAnimation) {
            viewModel.newGame()
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
        case .gameOver:
            return "Game Over!"
        case .noMoreCards:
            return "No more cards!"
        }
    }
    
    var over: Bool {
        switch viewModel.state {
        case .match:
            return false
        case .noMatch:
            return false
        case .selectCard:
            return false
        case .gameOver:
            return true
        case .noMoreCards:
            return false
        }
    }
    var statusBackground: Color {
        switch viewModel.state {
        case .match:
            return Color("BackgroundMatch")
        case .noMatch:
            return Color("BackgroundNoMatch")
        case .selectCard:
            return Color("Background2")
        case .gameOver:
            return Color("BackgroundMatch")
        case .noMoreCards:
            return Color("Background2")
        }
    }
    
    let baseAnimation: Animation = Animation.easeInOut.speed(0.25)
    let cardChooseAnimation: Animation = Animation.easeInOut.speed(1)
    func randomLocation() -> CGSize {
        CGSize(width: Double.random(in: -1000 ... -400), height: Double.random(in: -1000 ... -400))
    }
}

struct ShapesSetGameView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesSetGameView()
    }
}

