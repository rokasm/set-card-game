//
//  ShapesSet.swift
//  Set Game
//
//  Created by Rokas Mikelionis on 2021-03-08.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

class ShapesSetGame: ObservableObject {
    typealias setGameType = SetGame<Color, Shape, Fill, NumberOfShapes>
    @Published private var model: setGameType = ShapesSetGame.createGame()
    
    static func createGame() -> setGameType {
        
        func getColor(index: Int) -> Color {
           return Color.allCases[index]
        }
        
        func getShape(index: Int) -> Shape {
            return Shape.allCases[index]
        }
        
        func getFill(index: Int) -> Fill {
            return Fill.allCases[index]
        }
        
        func getNumberOfShapes(index: Int) -> NumberOfShapes {
            return NumberOfShapes.allCases[index]
        }
        
        return setGameType(colors: getColor, shapes: getShape, fills: getFill, numbersOfShapes: getNumberOfShapes)
        
    }
    
    enum Color: String, Hashable, CaseIterable {
        case blue = "blue"
        case red = "red"
        case orange = "orange"
    }
    
    enum Shape: String, CaseIterable, Hashable {
        case rectangle = "rectangle"
        case squiggle = "squiggle"
        case circle = "cirlce"
    }
    
    enum Fill: CaseIterable {
        case solid, striped, outlined
    }
    
    enum NumberOfShapes: Int, CaseIterable, Hashable {
        case one = 1, two, three
    }
    
    var deck: [setGameType.Card] {
        model.deck
    }
    
    var dealtCards: [setGameType.Card] {
        model.dealtCards
    }
    
    func chooseCard(card: setGameType.Card) {
        model.chooseCard(card: card)
    }
    
    var state: setGameType.State {
        model.state
    }
    
    func dealCards(count: Int) {
        model.dealCards(count: count)
    }
    
    func newGame() {
       model = ShapesSetGame.createGame()
    }
}
