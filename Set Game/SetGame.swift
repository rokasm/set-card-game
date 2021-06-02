//
//  SetGame.swift
//  Set Game
//
//  Created by Rokas Mikelionis on 2021-03-07.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import Foundation

struct SetGame<Color: Equatable, Shape: Equatable, Fill: Equatable, NumberOfShapes: Equatable> {
    private(set) var deck: [Card] = []
    
    private var colorsSet: [Color] = []
    private var shapesSet: [Shape] = []
    private var fillsSet: [Fill] = []
    private var numbersOfShapesSet: [NumberOfShapes] = []
    
    var selectedCards: [Card] { deck.filter{ $0.isSelected && $0.isDealt }}
    var dealtCards: [Card] { deck.filter{ $0.isDealt }}
    var availableCards: [Card] { deck.filter{!$0.isMatched && $0.isDealt}}
    var undealtCards: [Card] { deck.filter{ !$0.isMatched && !$0.isDealt }}
    
    var state: State = .selectCard
    var score: Int = 0
    var combinations: [[Card]] = []
    
    init(colors: (Int) -> Color, shapes: (Int) -> Shape, fills: (Int) -> Fill, numbersOfShapes: (Int) -> NumberOfShapes) {
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
        var cardsDealt = 0
        if undealtCards.count == 0 {
            state = .noMoreCards
        }
        
        for card in undealtCards {
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
        if selectedCards.count == 3 && state == .noMatch || state == .match {
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
            if case .match = checkMatch(selectedCards: selectedCards) {
                state = .match
                completeSet()
            }
            
            if case .noMatch = checkMatch(selectedCards: selectedCards) {
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
        score += 1
        
        if undealtCards.count == 0 && dealtCards.count < 13  {
            combinations = []
            checkCombinations(arr: dealtCards, n: dealtCards.count, r: 3)
            var states = [State]()
         
            for combination in combinations {
                let st = checkMatch(selectedCards: combination)
             
                if st == .match {
                    states.append(st)
                }
            }
            if states.count == 0 {
                state = .gameOver
            }
        }
    }
    
    mutating func checkMatch(selectedCards: [Card]) -> State {
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
    
    mutating func deal3cards() {
        dealCards(count: 3)
        if state != .gameOver && state != .noMoreCards {
            score -= 1
        }
    }
    
    mutating func combinationUtil(arr: [Card], n: Int, r: Int, index: Int, data: [Card], i: Int) {
        var dataCont = data
        // Current combination is ready to
        // be printed, print it
        if (index == r)
        {
            var combination: [Card] = []
            for j in 0..<r {
                combination.append(dataCont[j])
            }
            combinations.append(combination)
            return;
        }
        // When no more elements are there
        // to put in data[]
        if (i >= n) {
            return
        }
        // current is included, put next
        // at next location
        dataCont.insert(arr[i], at: index);
        combinationUtil(arr: arr, n: n, r: r, index: index + 1, data: dataCont, i: i + 1);
        
        // current is excluded, replace
        // it with next (Note that i+1
        // is passed, but index is not
        // changed)
        combinationUtil(arr: arr, n: n, r: r, index: index, data: dataCont, i: i + 1);
    }
    
    mutating func checkCombinations(arr: [Card], n: Int, r: Int)
    {
        // A temporary array to store all
        // combination one by one
        let data: [Card] = []
        // Print all combination using
        // temprary array 'data[]'
        combinationUtil(arr: arr, n: n, r: r, index: 0, data: data, i: 0);
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
        case noMoreCards
        case gameOver
    }
}
