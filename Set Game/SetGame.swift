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
    var selectedCards: [Card] { self.deck.filter{ $0.isSelected && $0.isDealt }}
    var dealtCards: [Card] { self.deck.filter{ $0.isDealt }}
    var state: State
    
    init(colors: (Int) -> Color, shapes: (Int) -> Shape, fills: (Int) -> Fill, numbersOfShapes: (Int) -> NumberOfShapes) {
        deck = [Card]()
        colorsSet = [Color]()
        shapesSet = [Shape]()
        fillsSet = [Fill]()
        numbersOfShapesSet = [NumberOfShapes]()
        state = .selectCard
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
    }
    
    mutating func dealCards(count: Int) {
        print("\(count)")
        var cardsDealt = 0
        let availableCards = deck.filter{!$0.isMatched && !$0.isDealt && !$0.isSelected}
        for card in availableCards {
            if let selectedIndex: Int = deck.firstIndex(matching: card) {
                deck[selectedIndex].isDealt = true
                cardsDealt += 1
            }
            if (cardsDealt >= count) {
                break
            }
        }
    }
    
    mutating func chooseCard(card: Card) {
        
        // reset selection if there is no match
        if selectedCards.count == 3 && state == .noMatch {
            state = .selectCard
            if let firstIndex: Int = deck.firstIndex(matching: card) {
                self.deck[firstIndex].isSelected = true
                for card in selectedCards {
                    if let firstIndex: Int = deck.firstIndex(matching: card) {
                        self.deck[firstIndex].isSelected = false
                    }
                }
            }
        }
        
        if let firstIndex: Int = deck.firstIndex(matching: card) {
            self.deck[firstIndex].isSelected.toggle()
        }
        
        if selectedCards.count == 3 {
            if case .match = checkMatch() {
                state = .match
                completeSet()
            }
            
            if case .noMatch = checkMatch() {
                state = .noMatch
            }
        }
    }
    
    mutating func completeSet() {
        for card in selectedCards {
            if let selectedIndex = deck.firstIndex(matching: card) {
                self.deck[selectedIndex].isMatched = true
                self.deck[selectedIndex].isDealt = false
                self.deck[selectedIndex].isSelected = false
            }
        }
        if dealtCards.count <= 12 {
            dealCards(count: 3)
        }
    }
    
    mutating func checkMatch() -> State {
        var colors: [Int] = []
        var shapes: [Int] = []
        var fills: [Int] = []
        var numbersOfShapes: [Int] = []
        func checkColor(parameter: [Color], item: Color) -> Int? {
            switch item {
            case parameter[0]:
                return 0
            case parameter[1]:
                return 1
            case parameter[2]:
                return 2
            default:
                return nil
            }
        }
        
        func checkShape(parameter: [Shape], item: Shape) -> Int? {
            switch item {
            case parameter[0]:
                return 0
            case parameter[1]:
                return 1
            case parameter[2]:
                return 2
            default:
                return nil
            }
        }
        
        func checkFill(parameter: [Fill], item: Fill) -> Int? {
            switch item {
            case parameter[0]:
                return 0
            case parameter[1]:
                return 1
            case parameter[2]:
                return 2
            default:
                return nil
            }
        }
        
        func checkNumberOfShapes(parameter: [NumberOfShapes], item: NumberOfShapes) -> Int? {
            switch item {
            case parameter[0]:
                return 0
            case parameter[1]:
                return 1
            case parameter[2]:
                return 2
            default:
                return nil
            }
        }
        
        for card in selectedCards {
            colors.append(checkColor(parameter: colorsSet, item: card.color) ?? 0)
            shapes.append(checkShape(parameter: shapesSet, item: card.shape) ?? 0)
            fills.append(checkFill(parameter: fillsSet, item: card.fill) ?? 0)
            numbersOfShapes.append(checkNumberOfShapes(parameter: numbersOfShapesSet, item: card.numberOfShapes) ?? 0)
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
        case selectCard
    }
}
