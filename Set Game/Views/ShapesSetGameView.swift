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
    @State private var rulesPopUpVisible: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle().fill(
                LinearGradient(gradient: Gradient(
                                colors: [statusBackground, Color("Background2")]),
                               startPoint: .topTrailing,
                               endPoint: .bottomLeading))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(status)
                    .font(.system(size: 27, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(Color("TextColorTitle1"))
                    .shadow(color: Color.black.opacity(0.25), radius: 0.1, x: -1 , y: 1)
                    .transition(.opacity)
                Text("Score: \(viewModel.score)")
                    .font(.system(size: 21, design: .rounded))
                    .foregroundColor(Color("TextDark"))
                Grid(viewModel.dealtCards) { card in
                    CardView(card: card).transition(AnyTransition.offset(randomLocation())).onTapGesture {
                        withAnimation(Animation.easeInOut) {
                            self.viewModel.chooseCard(card: card)
                        }
                    }
                }
                if !rulesPopUpVisible {
                HStack {
                        Button(action: {
                                withAnimation(baseAnimation){
                                    viewModel.dealCards(count: 3) }}) {
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
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .shadow(color: Color.black.opacity(0.25), radius: 0.1, x: -1 , y: 1)
                .transition(.opacity)
            }
            }
            if rulesPopUpVisible {
                PopupView(rulesPopUpVisible: self.$rulesPopUpVisible, action: self.viewModel.newGame)
            }
        }
        .onAppear() {
            rulesPopUpVisible = true
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
    let baseAnimation: Animation = Animation.easeInOut.speed(0.5)
    func randomLocation() -> CGSize {
        CGSize(width: Double.random(in: -500 ... 500), height: Double.random(in: -500 ... 500))
    }
}

struct ShapesSetGameView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesSetGameView()
    }
}

