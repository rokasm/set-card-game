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
            Grid(viewModel.dealtCards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.chooseCard(card: card)
                }
            }
        }
    }
}

struct CardView: View {
    var card: SetGame<ShapesSetGame.Color, ShapesSetGame.Shape, ShapesSetGame.Fill, ShapesSetGame.NumberOfShapes>.Card
    
    var color : Color {
        switch card.color {
        case .orange:
            return Color("CardColor1")
        case .blue:
            return Color("CardColor2")
        case .red:
            return Color("CardColor3")
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(size: geometry.size)
        }
    }
    
    private func body(size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color("CardFill"))
            RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(color, lineWidth: 2)
            VStack {
                ForEach(0..<card.numberOfShapes.rawValue) {_ in
                    self.drawShapes().padding(2)
                }.frame(width: 25, height: 25)
            }
        }
        .font(Font.system(size: fontSize(for: size)))
        .padding(self.card.isSelected ? 2 : cardPadding)
    }
    
    @ViewBuilder
    func drawShapes() -> some View {
        if self.card.shape == .diamond {
            Diamond().fill(color)
        }
        if self.card.shape == .rectangle {
            Rectangle().fill(color)
        }
        if self.card.shape == .circle {
            Circle().fill(color)
        }
    }
    
    
    private let cornerRadius: CGFloat = 15
    private let cardPadding: CGFloat = 10
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

