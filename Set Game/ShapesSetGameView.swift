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
    
    var status: String {
        switch self.viewModel.state {
        case .match:
            return "Set!"
        case .noMatch:
            return "No match"
        case .selectCard:
            return "Select Card"
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill( LinearGradient(gradient: Gradient(colors: [Color("Background1"), Color("Background2")]), startPoint: .topTrailing, endPoint: .bottomLeading))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(status)
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(Color("TextColorTitle1"))
                Grid(viewModel.dealtCards) { card in
                    CardView(card: card).onTapGesture {
                        self.viewModel.chooseCard(card: card)
                    }
                }
                HStack {
                    Button(action: {viewModel.dealCards(count: 3)}) {
                        Text("Deal 3 More Cards")
                            .font(.system(size: 21, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(Color("TextColorTitle1"))
                    }
                    Spacer()
                    Button(action: {viewModel.newGame()}) {
                        Text("New Game")
                            .font(.system(size: 21, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color("TextColorTitle1"))
                    }
                }.padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
            }
        }
    }
}

struct ShapesSetGameView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesSetGameView()
    }
}

