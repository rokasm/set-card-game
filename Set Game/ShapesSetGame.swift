//
//  ShapesSet.swift
//  Set Game
//
//  Created by Rokas Mikelionis on 2021-03-08.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

class ShapesSetGame: ObservableObject {
    typealias setGameType = SetGame<Colors, Shapes, Fills, NumbersOfShapes>
    @Published private var model: setGameType = ShapesSetGame.createGame()

    static func createGame() -> setGameType {
                
        return setGameType(colors: Colors.allCases, shapes: Shapes.allCases, fills: Fills.allCases, numbersOfShapes: NumbersOfShapes.allCases)
        
    }
    
    enum Colors: CaseIterable {
        case blue
        case red
        case orange
    }
    
       enum Shapes: CaseIterable {
        case rectangle, diamond, circle
    }
       
       enum Fills: CaseIterable {
           case solid, shaded, outlined
    }
       
       enum NumbersOfShapes: Int, CaseIterable {
           case one = 1, two, three
    }
    
    var deck: Array<SetGame<Colors, Shapes, Fills, NumbersOfShapes>.Card> {
        model.deck
    }
    
    var cardsDealt: Array<setGameType.Card> {
          model.cardsDealt
    }
    
    func chooseCard(card: setGameType.Card) {
        model.chooseCard(card: card)
    }
}
