//
//  CardView.swift
//  Set Game
//
//  Created by Rokas Mikelionis on 2021-04-10.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var card: SetGame<ShapesSetGame.Color, ShapesSetGame.Shape, ShapesSetGame.Fill, ShapesSetGame.NumberOfShapes>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(size: geometry.size)
        }
    }
    
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
    var stroke : CGFloat {
        card.fill == .outlined || card.fill == .striped ? 2 : 0
    }
    var opacity: Double {
        card.fill == .outlined ? 0 : 1
    }
    
    var reflectionColor: Color {
        switch card.color {
        case .orange:
            return Color("CardColor1Reflection")
        case .blue:
            return Color("CardColor2Reflection")
        case .red:
            return Color("CardColor3Reflection")
        }
    }
    
    private func body(size: CGSize) -> some View {
        ZStack {
            Rectangle().fill(color)
            .aspectRatio(3/4, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius(for: size), style: .continuous))
            .shadow(color: Color.black.opacity(0.25), radius: card.isSelected ? cardShadowRadiusSelected(for: size.height) : cardShadowRadius(for: size.height), x: card.isSelected ? -cardShadowSelected(for: size.width) : -cardShadow(for: size.width), y: card.isSelected ? cardShadowSelected(for: size.height) : cardShadow(for: size.height))
                .padding(5)
            VStack {
                ForEach(0..<card.numberOfShapes.rawValue) {_ in
                    self.drawShapes().padding(shapePadding(for: size)).frame(width: shapeSize(for: size), height: shapeSize(for: size))
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
        .scaleEffect(self.card.isSelected ? selectedCardScale : 1)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: cardPadding(for: size), trailing: 0))
        .frame(width: size.width, height: size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

    }
    
    @ViewBuilder
    func drawShapes() -> some View {
        switch card.shape {
        case .squiggle:
            SquiggleView(lineWidth: stroke, color: .white, striped: card.fill == .striped)
                .aspectRatio(1.5, contentMode: .fill)
        case .rectangle:
            Rectangle().strokeBorder(Color.white, lineWidth: stroke).background(
                Rectangle().fill(shapeFill(striped: card.fill == .striped)).opacity(opacity))
        case .circle:
            Circle().strokeBorder(Color.white, lineWidth: stroke).background(
                Circle().fill(shapeFill(striped: card.fill == .striped)).opacity(opacity))
        }
        
    }
    
    @ViewBuilder
    func SquiggleView(lineWidth: CGFloat, color: Color, striped: Bool) -> some View {
        ZStack {
            Squiggle().stroke(color, lineWidth: lineWidth)
            Squiggle().fill(shapeFill(striped: striped)).opacity(opacity)
        }
    }
    private func cornerRadius(for size: CGSize) -> CGFloat {
        max(size.width, size.height) * 0.1
    }
    private let selectedCardScale: CGFloat = 1.1
    
    private func cardPadding(for size: CGSize) -> CGFloat {
        max(size.width, size.height) * 0.1
    }
    private func fontSize(for size: CGSize) -> CGFloat {
        max(size.width, size.height) * 0.75
    }
    private func shapeSize(for size: CGSize) -> CGFloat {
        max(size.width, size.height) * 0.2
    }
    private func shapePadding(for size: CGSize) -> CGFloat {
        max(size.width, size.height) * 0.015
    }
    private let reflectionOpacity: Double = 1
    
    private func cardShadow(for size: CGFloat) -> CGFloat {
        size * 0.01
    }
    private func cardShadowRadius(for size: CGFloat) -> CGFloat {
        size * 0.005
    }
    private func cardShadowSelected(for size: CGFloat) -> CGFloat {
        size * 0.12
    }
    private func cardShadowRadiusSelected(for size: CGFloat) -> CGFloat {
        size * 0.04
    }
    private func shapeFill(striped: Bool = false) -> LinearGradient {
        let color1: Color = Color.white
        let color2: Color = Color.white.opacity(0.4)
        if striped {
            return LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: color2, location: 0),
                    .init(color: color2, location: 0.30),
                    .init(color: color1, location: 0.30),
                    .init(color: color1, location: 0.45),
                    .init(color: color2, location: 0.45),
                    .init(color: color2, location: 0.75),
                    .init(color: color1, location: 0.75),
                    .init(color: color1, location: 0.9),
                    .init(color: color2, location: 1),
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        }
        else {
            return LinearGradient(
                gradient: Gradient(colors: [color1]), startPoint: .top, endPoint: .bottom)
        }
    }
  
}
