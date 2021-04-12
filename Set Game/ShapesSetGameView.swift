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
        VStack {
            Text(status)
            Grid(viewModel.dealtCards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.chooseCard(card: card)
                }
            }
            Button(action: {viewModel.dealCards(count: 3)}) { Text("Deal 3 More Cards")}
            Button(action: {viewModel.newGame()}) { Text("New Game")}
        }
    }
}

struct ShapesSetGameView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesSetGameView()
    }
}

