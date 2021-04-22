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
    @State private var rulesPopUpVisible = false
    
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
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(Color("TextColorTitle1"))
                    .shadow(color: Color.black.opacity(0.25), radius: 0.1, x: -1 , y: 1)
                    .transition(.identity)
                Grid(viewModel.dealtCards) { card in
                    CardView(card: card).transition(AnyTransition.offset(randomLocation())).onTapGesture {
                        withAnimation(Animation.easeInOut) {
                            self.viewModel.chooseCard(card: card)
                        }
                    }
                }
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
            }
            if rulesPopUpVisible {
                ZStack() {
                    RoundedRectangle(cornerRadius: 25).fill(
                        LinearGradient(gradient: Gradient(
                                        colors: [statusBackground, Color("Background2")]),
                                       startPoint: .topTrailing,
                                       endPoint: .bottomLeading)).edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 50) {
                        Text("Choose 3 cards to make a set. A Set is made when the 3 cards complete these requirements:")
                            .font(.system(size: 24, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                            .foregroundColor(Color("TextColorTitle1"))
                            .multilineTextAlignment(.center)
                            .animation(Animation.easeInOut.speed(0.25).delay(0.2))
                            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0 , y: 0)
                        VStack {
                            Group {
                                Text("They all have the same number or have three different numbers.").fontWeight(.bold)
                                Text("They all have the same shape or have three different shapes.").fontWeight(.bold)
                                Text("They all have the same shading or have three different shadings.").fontWeight(.bold)
                                Text("They all have the same color or have three different colors.").fontWeight(.bold)
                                Text("They all have the same number or have three different numbers.").fontWeight(.bold)
                            }.padding(EdgeInsets(top: 0, leading: 50, bottom: 5, trailing: 50))
                            .font(.system(size: 18, design: .rounded))
                            .foregroundColor(Color("TextColorTitle1"))
                            .multilineTextAlignment(.center)
                            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 0 , y: 0)
                        }
                        .animation(Animation.easeInOut.speed(0.25).delay(0.3))
                        Button(action: {
                            withAnimation(baseAnimation){
                                viewModel.dealCards(count: 12)
                                rulesPopUpVisible = false
                            }
                            
                        }) {
                            Text("PLAY")
                                .font(.system(size: 48, design: .rounded))
                                .fontWeight(.heavy)
                                .foregroundColor(Color("TextColorTitle1"))
                        }
                        .animation(Animation.easeInOut.speed(0.25).delay(0.4))
                        .shadow(color: Color.black.opacity(0.25), radius: 2, x: -1 , y: 1)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }.transition(.move(edge: .top))
            }
        }
        .onAppear() {
                rulesPopUpVisible = false
            viewModel.dealCards(count: 12)
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

