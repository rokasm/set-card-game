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
    
    var body: some View {
        VStack {
            Grid(viewModel.cardsDealt) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.chooseCard(card: card)
                }
            }
        }
    }
}

struct CardView: View {
    var card: SetGame<ShapesSetGame.Colors, ShapesSetGame.Shapes, ShapesSetGame.Fills, ShapesSetGame.NumbersOfShapes>.Card
    
    var color : Color {
        switch card.color {
        case .blue:
            return Color("CardColor1")
        case .red:
            return Color("CardColor2")
        case .orange:
            return Color("CardColor3")
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(size: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).fill(color)
            VStack {
                ForEach(0..<card.numberOfShapes.rawValue) {_ in
                    self.drawShapes()
                }.frame(width: 10, height: 10)
            }
        }.font(Font.system(size: fontSize(for: size))).padding(cardPadding)
    }
    
    @ViewBuilder
    func drawShapes() -> some View {
        if self.card.shape == .diamond {
            Diamond()
        }
        if self.card.shape == .rectangle {
            Rectangle()
        }
        if self.card.shape == .circle {
            Circle()
        }
    }
    
    
    private let cornerRadius: CGFloat = 10
    private let cardPadding: CGFloat = 3
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
    private func shapeSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.25
    }
}


struct ShapesSetGameView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesSetGameView()
    }
}

