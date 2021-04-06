//
//  SetGame.swift
//  Set Game
//
//  Created by Rokas Mikelionis on 2021-03-07.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import Foundation

struct SetGame<Color: Equatable, Shape: Equatable, Fill: Equatable, NumberOfShapes: Equatable> {
    private(set) var deck: [Card]
    private var colorsSet: [Color]
    private var shapesSet: [Shape]
    private var fillsSet: [Fill]
    private var numbersOfShapesSet: [NumberOfShapes]
    
    var selectedCards: [Card] {
        get { self.deck.filter{ $0.isSelected && $0.isDealt } }
    }
    var dealtCards: [Card] {
        get { self.deck.filter{ $0.isDealt} }
    }
    
    
    init(colors: (Int) -> Color, shapes: (Int) -> Shape, fills: (Int) -> Fill, numbersOfShapes: (Int) -> NumberOfShapes) {
        deck = [Card]()
        colorsSet = [Color]()
        shapesSet = [Shape]()
        fillsSet = [Fill]()
        numbersOfShapesSet = [NumberOfShapes]()
        
        for color in 0..<3 {
            colorsSet.append(colors(color))
            for shape in 0..<3 {
                shapesSet.append(shapes(shape))
                for fill in 0..<3 {
                    fillsSet.append(fills(fill))
                    for numberOfShapes in 0..<3 {
                        numbersOfShapesSet.append(numbersOfShapes(numberOfShapes))
                        deck.append(Card(id: UUID(), color: colors(color), shape: shapes(shape), fill: fills(fill), numberOfShapes: numbersOfShapes(numberOfShapes)))
                    }
                }
            }
        }
        deck.shuffle()
        dealCards(count: 12)
    }
    
    mutating func dealCards(count: Int) {
        for card in 0..<count {
            if !self.deck[card].isDealt {
                self.deck[card].isDealt = true
            } else {
                continue
            }
        }
    }
    
    
    mutating func chooseCard(card: Card) {
        print(card)
       
        if let firstIndex: Int = deck.firstIndex(matching: card) {
            self.deck[firstIndex].isSelected.toggle()
        }

        if selectedCards.count == 3 {
            print("\(checkMatch())")
            switch checkMatch() {
            case .match:
                completeSet()
            case .noMatch:
                unSelectCards()
            }
        }
    }
    
    mutating func completeSet() {
        for card in selectedCards {
            if let selectedIndex = deck.firstIndex(matching: card) {
                self.deck[selectedIndex].isMatched = true
                unSelectCards()
            }
        }
    }
    
    mutating func unSelectCards() {
        for card in selectedCards {
            if let selectedIndex: Int = deck.firstIndex(matching: card) {
                deck[selectedIndex].isSelected = false
            }
        }
    }
    
    mutating func checkMatch() -> State {
        var colors: [Int] = []
        var shapes: [Int] = []
        var fills: [Int] = []
        var numbersOfShapes: [Int] = []
        func checkColor(parameter: [Color], item: Color) -> Int {
            switch item {
            case parameter[0]:
                return 0
            case parameter[1]:
                return 1
            case parameter[2]:
                return 2
            default:
                return -1
            }
        }
        
        func checkShape(parameter: [Shape], item: Shape) -> Int {
            switch item {
            case parameter[0]:
                return 0
            case parameter[1]:
                return 1
            case parameter[2]:
                return 2
            default:
                return -1
            }
        }
        
        func checkFill(parameter: [Fill], item: Fill) -> Int {
            switch item {
            case parameter[0]:
                return 0
            case parameter[1]:
                return 1
            case parameter[2]:
                return 2
            default:
                return -1
            }
        }
        
        func checkNumberOfShapes(parameter: [NumberOfShapes], item: NumberOfShapes) -> Int {
            switch item {
            case parameter[0]:
                return 0
            case parameter[1]:
                return 1
            case parameter[2]:
                return 2
            default:
                return -1
            }
        }
        
        for card in selectedCards {
            colors.append(checkColor(parameter: colorsSet, item: card.color))
            shapes.append(checkShape(parameter: shapesSet, item: card.shape))
            fills.append(checkFill(parameter: fillsSet, item: card.fill))
            numbersOfShapes.append(checkNumberOfShapes(parameter: numbersOfShapesSet, item: card.numberOfShapes))
        }
        
        // returns the count of unique parameters
        // 1 = all three parameters are the same
        // 2 = two parameters are the same
        // 3 = all three parameters are different
        // if there are two identical parameters, set cannot be made
        func checkMatch(element: [AnyHashable]) -> Bool {
            return Array(Set(element)).count != 2
        }
        return checkMatch(element: colors) && checkMatch(element: shapes) && checkMatch(element: fills) && checkMatch(element: numbersOfShapes) ? .match : .noMatch
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
    
    enum State {
        case match
        case noMatch
        
    }
}
