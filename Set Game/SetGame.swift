//
//  SetGame.swift
//  Set Game
//
//  Created by Rokas Mikelionis on 2021-03-07.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import Foundation

struct SetGame<Color, Shape, Fill, NumberOfShapes> {
    private(set) var deck: Array<Card>
    private(set) var cardsDealt: Array<Card>
    
    func selectCard(card: Card) {
        print("card chosen: \(card)")
    }
    
    init(colors: [Color], shapes: [Shape], fills: [Fill], numbersOfShapes: [NumberOfShapes]) {
        deck = [Card]()
        cardsDealt = [Card]()
            for color in colors {
                for shape in shapes {
                    for fill in fills {
                        for numberOfShapes in numbersOfShapes {
                            deck.append(Card(id: UUID(), color: color, shape: shape, fill: fill, numberOfShapes: numberOfShapes))
                        }
                    }
                }
            }
        deck.shuffle()
        cardsDealt = self.dealCards(deck: deck)
    }
    
    struct Card: Identifiable {
        var id: UUID
        var color: Color
        var shape: Shape
        var fill: Fill
        var numberOfShapes: NumberOfShapes
        var isDealt: Bool = false
        var isSelected: Bool = false
        var isMatched: Bool = false
    }
    
    mutating func dealCards(deck: [Card]) -> [Card] {
        var cardsDealt: [Card] = []
        print("\(cardsDealt.count)")

        for card in deck {
            if cardsDealt.count >= 12 {
                break
            }

            if let firstIndex: Int = deck.firstIndex(matching: card), !deck[firstIndex].isDealt {
                    self.deck[firstIndex].isDealt = true
                               cardsDealt.append(card)
                           }
        }
        return cardsDealt
    }
    
    mutating func chooseCard(card: Card) {
        
    }
}
