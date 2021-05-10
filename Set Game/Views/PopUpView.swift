//
//  PopupView.swift
//  Set Game
//
//  Created by Rokas Mikelionis on 2021-04-23.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

struct PopupView: View {
    @Binding var rulesPopUpVisible: Bool
    var action: () -> Void
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 25).fill(
                LinearGradient(gradient: Gradient(
                                colors: [Color("Background1"), Color("Background2")]),
                               startPoint: .topTrailing,
                               endPoint: .bottomLeading)).edgesIgnoringSafeArea(.all)
            
            VStack() {
                Text("Choose 3 cards to make a set. A Set is made when the 3 cards complete ALL these requirements:")
                    .font(.system(size: 21, design: .rounded))
                    .fontWeight(.heavy)
                    .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
                    .foregroundColor(Color("TextColorTitle1"))
                    .multilineTextAlignment(.center)
                    .animation(Animation.easeInOut.speed(0.5))
                    .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0 , y: 0)
                VStack {
                    Group {
                        Text("They all have the same number or have three different numbers of shapes.").animation(Animation.easeInOut.speed(0.5).delay(0.1))
                        HStack {
                            CardView(card: SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one))
                            CardView(card: SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.two))
                            CardView(card: SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.three))
                        }
                        Text("They all have the same shape or have three different shapes.").animation(Animation.easeInOut.speed(0.5).delay(0.2))
                        HStack {
                            CardView(card: SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one))
                            CardView(card: SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.rectangle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one))
                            CardView(card: SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.squiggle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one))
                        }
                        Text("They all have the same shading or have three different shadings.").animation(Animation.easeInOut.speed(0.5).delay(0.3))
                        HStack {
                            CardView(card: SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one))
                            CardView(card: SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.solid, numberOfShapes: ShapesSetGame.NumberOfShapes.one))
                            CardView(card: SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.circle, fill: ShapesSetGame.Fill.outlined, numberOfShapes: ShapesSetGame.NumberOfShapes.one))
                        }
                        Text("They all have the same color or have three different colors.").animation(Animation.easeInOut.speed(0.5).delay(0.4))
                        HStack {
                            CardView(card: SetGame.Card(id: UUID(), color: ShapesSetGame.Color.red, shape: ShapesSetGame.Shape.squiggle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one))
                            CardView(card: SetGame.Card(id: UUID(), color: ShapesSetGame.Color.blue, shape: ShapesSetGame.Shape.squiggle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one))
                            CardView(card: SetGame.Card(id: UUID(), color: ShapesSetGame.Color.orange, shape: ShapesSetGame.Shape.squiggle, fill: ShapesSetGame.Fill.striped, numberOfShapes: ShapesSetGame.NumberOfShapes.one))
                        }
                        
                    }
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(Color("TextColorTitle1"))
                    .multilineTextAlignment(.center)
                    .shadow(color: Color.black.opacity(0.5), radius: 1, x: -1 , y: 1)
                }
                .animation(Animation.easeInOut.speed(0.5).delay(0.75))
                Button(action: {
                    withAnimation(Animation.easeInOut.speed(0.5)){
                        self.rulesPopUpVisible.toggle()
                        self.action()
                    }
                    
                }) {
                    Text("PLAY")
                        .font(.system(size: 42, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("TextColorTitle1"))
                }
                .padding(20)
                .background(Color.white.opacity(0.2))
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.5), radius: 1, x: -1 , y: 1)
                .animation(Animation.easeInOut.speed(0.5).delay(0.5))

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .transition(.opacity)
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(rulesPopUpVisible: .constant(true), action: {})
    }
}
