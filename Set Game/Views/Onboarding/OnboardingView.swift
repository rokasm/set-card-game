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
    @AppStorage("onboardingVisible") var onboardingVisible: Bool = false
    
    var body: some View {
        ZStack() {
            Rectangle().fill(
                LinearGradient(gradient: Gradient(
                                colors: [Color("Background2"), Color("Background1")]),
                               startPoint: .topTrailing,
                               endPoint: .bottomLeading))
                .edgesIgnoringSafeArea(.all)
            VStack() {
                TabView(selection: $selection) {
                    VStack {
                        Text("Choose 3 cards to make a set")
                            .font(.system(size: 24, design: .rounded))
                            .fontWeight(.semibold)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                        Text("A Set is made when all 3 cards complete these 4 requirements:")
                            .font(.system(size: 24, design: .rounded))
                            .fontWeight(.semibold)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
                        Text("1. They all have the same color or have three different colors.")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                        Text("2. They all have the same shape or have three different shapes.")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                        Text("3. They all have the same number or have three different numbers of shapes")
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                        Text("4. They all have the same shading or have three different shadings.")
                    }
                    .font(.system(size: 21, design: .rounded))
                    .foregroundColor(Color("TextColorTitle1"))
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
                    .shadow(radius: 1, x: -1, y: 1)
                    .transition(.opacity)
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                    .tag(0)

                    VStack {
                        TabItemView(content:  TabData(text: "This is a set", cards: [
                            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
                            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
                            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.squiggle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one)
                        ]))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 64, trailing: 0))
                        TabItemView(content: TabData(text: "This is also a set", cards: [
                            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
                            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.three),
                            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.squiggle, fill: ShapesSetGame.Fill.outlined, numberOfShapes: ShapesSetGame.NumberOfShapes.two)
                        ]))
                    }.tag(1)
                    VStack {
                        TabItemView(content: TabData(text: "This is not a set", cards: [
                            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
                            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.two),
                            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.three)
                        ]))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 64, trailing: 0))
                        TabItemView(content: TabData(text: "This is also not a set", cards: [
                            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
                            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.outlined, numberOfShapes: ShapesSetGame.NumberOfShapes.three),
                            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.squiggle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.three)
                        ]))
                    }.tag(2)
                }
                .tabViewStyle(PageTabViewStyle())
                Button(action:  {
                    if selection < 2 {
                        withAnimation() {
                            selection += 1
                        }
                    } else {
                        withAnimation(Animation.easeInOut.speed(0.25)) {
                            onboardingVisible = false
                        }
                    }
                } ) {
                    Text(selection < 2 ? "Next" : "Play")
                        .font(.system(size: 32, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("TextColorTitle1"))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
                        .shadow(color: Color.black.opacity(0.25), radius: 0.1, x: -1 , y: 1)
                }
            }
        }
    }
    
    struct TabData {
        var text: String
        var cards: [setGameType.Card]
    }
    
    var tabs: [TabData] = [
        TabData(text: "They all have the same or three different shapes", cards: [
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.squiggle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one)
        ]),
        TabData(text: "They all have the same or three different shadings", cards: [
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.outlined, numberOfShapes: ShapesSetGame.NumberOfShapes.one)
        ]),
        TabData(text: "They all have the same or three different number of shapes", cards: [
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.two),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.three)
        ]),
        TabData(text: "They all have the same or three different colors", cards: [
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one),
            SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one)
        ]),
    ]
}
