//
//  PopupView.swift
//  Set Game
//
//  Created by Rokas Mikelionis on 2021-04-23.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

struct OnboardingView : View {
    @State private var selection = 0
    typealias setGameType = SetGame<ShapesSetGame.Color, ShapesSetGame.Shape, ShapesSetGame.Fill, ShapesSetGame.NumberOfShapes>
    var action: () -> Void
    
    var body: some View {
        
        TabView(selection: $selection) {
            VStack {
                Text("Choose 3 cards to make a set")
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                Text("A Set is made when the 3 cards complete all these requirements")
                    .fontWeight(.semibold)
            }
            .tag(0)
            .font(.system(size: 21, design: .rounded))
            .foregroundColor(Color("TextColorTitle1"))
            .multilineTextAlignment(.center)
            .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
            .shadow(radius: 1, x: -1, y: 1)
            .transition(.opacity)
            ForEach(tabs.indices, id: \.self) { index in
                TabItemView(index: index+1, content: tabs[index], action: action)
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
    
    struct TabData {
        var text: String
        var cards: [setGameType.Card]
        var showButton: Bool = false
    }
    
    var tabs: [TabData] = [
        TabData(text: "They all have the same shape or have three different shapes", cards: [
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.squiggle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one)
        ]),
        TabData(text: "They all have the same shading or have three different shadings", cards: [
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.outlined, numberOfShapes: ShapesSetGame.NumberOfShapes.one)
        ]),
        TabData(text: "They all have the same shape or have three different shapes", cards: [
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.squiggle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one)
        ]),
        TabData(text: "They all have the same color or have three different colors", cards: [
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.squiggle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.squiggle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.squiggle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one)
        ], showButton: true),
    ]
}
