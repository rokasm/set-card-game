//
//  TabItemView.swift
//  Set Game
//
//  Created by Rokas Mikelionis on 2021-05-12.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

struct TabItemView: View {
    var content: OnboardingView.TabData
    
    var body: some View {
        VStack() {
            VStack {
                Text(content.text)
                    .font(.system(size: 21, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TextColorTitle1"))
                    .multilineTextAlignment(.center)
                    .shadow(radius: 1, x: -1, y: 1)
                HStack() {
                    ForEach(content.cards) { card in
                        CardView(card: card)
                    }
                }.frame(height: 140)
                
            }
            .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
          
        }
        
    }
}
