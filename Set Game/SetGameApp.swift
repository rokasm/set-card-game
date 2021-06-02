//
//  Memorize2021App.swift
//  Memorize2021
//
//  Created by Rokas Mikelionis on 2021-05-19.
//

import SwiftUI

@main
struct SetGameApp: App {
    
    let game = ShapesSetGame()
    var body: some Scene {
        WindowGroup {
            ShapesSetGameView(viewModel: game)
        }
    }
}

