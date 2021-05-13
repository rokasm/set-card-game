//
//  TabItemView.swift
//  Set Game
//
//  Created by Rokas Mikelionis on 2021-05-12.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

struct TabItemView: View {
    var index: Int
    var content: OnboardingView.TabData
    var action: () -> Void

    @ObservedObject var viewModel = ShapesSetGame()
    @AppStorage("onboardingVisible") var onboardingVisible: Bool = false

    var body: some View {
        VStack {
            Text(content.text)
                .font(.system(size: 18, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(Color("TextColorTitle1"))
                .multilineTextAlignment(.center)
                .shadow(radius: 1, x: -1, y: 1)
            HStack() {
                ForEach(content.cards) { card in
                    CardView(card: card)
                }
            }.frame(height: 140)
            if content.showButton {
                Button(action: {
                    withAnimation(Animation.easeInOut.speed(0.25)){
                        self.onboardingVisible.toggle()
                        self.action()
                    }
                    
                }) {
                    Text("PLAY")
                        .font(.system(size: 32, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("TextColorTitle1"))
                }
                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                .background(Color.white.opacity(0.2))
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.5), radius: 1, x: -1 , y: 1)
                .animation(Animation.easeInOut.speed(0.75).delay(1))
            }
        }
        .tag(index)
        .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
     
    }
}
