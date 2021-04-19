//
//  Squiggle.swift
//  Set Game
//
//  Created by Rokas Mikelionis on 2021-03-22.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

struct Squiggle: Shape {
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let curve1: (to: CGPoint, control: CGPoint) = (
            CGPoint(x: rect.maxX*0.29, y: rect.maxY * 0.08),
            CGPoint(x: rect.minX, y: rect.maxY * 0.1))
        
        let curve2: (to: CGPoint, control: CGPoint) = (
            CGPoint(x: rect.maxX * 0.58, y: rect.maxY * 0.3),
            CGPoint(x: rect.maxX * 0.4, y: rect.maxY*0.08))
        
        let curve3: (to: CGPoint, control: CGPoint) = (
            CGPoint(x: rect.maxX * 0.93, y: rect.maxY * 0.25),
            CGPoint(x: rect.maxX * 0.82 , y: rect.maxY * 0.63))
        
        let curve4: (to: CGPoint, control: CGPoint) = (
            CGPoint(x: rect.maxX * 0.99, y: rect.maxY * 0.3),
            CGPoint(x: rect.maxX * 0.97, y: rect.maxY * 0.12))
        
        let curve5: (to: CGPoint, control: CGPoint) = (
            CGPoint(x: rect.maxX * 0.5, y: rect.maxY * 0.45),
            CGPoint(x: rect.maxX * 0.87, y: rect.maxY * 0.98))
        
        let curve6: (to: CGPoint, control: CGPoint) = (
            CGPoint(x: rect.maxX * 0.06, y: rect.maxY * 0.55),
            CGPoint(x: rect.maxX * 0.2, y: rect.maxY * 0.1))
        
        let curve7: (to: CGPoint, control: CGPoint) = (
            CGPoint(x: rect.maxY * 0.01, y: rect.maxY*0.6),
            CGPoint(x: rect.maxY * 0.02, y: rect.maxY * 0.74))
        
        var p = Path()
        p.move(to: CGPoint(x: rect.maxY * 0.01, y: rect.maxY*0.6))
            p.addQuadCurve(to: curve1.to, control: curve1.control)
            p.addQuadCurve(to: curve2.to, control: curve2.control)
            p.addQuadCurve(to: curve3.to, control: curve3.control)
        p.addQuadCurve(to: curve4.to, control: curve4.control)
        p.addQuadCurve(to: curve5.to, control: curve5.control)
        p.addQuadCurve(to: curve6.to, control: curve6.control)
        p.addQuadCurve(to: curve7.to, control: curve7.control)

        return p
    }
    struct ShapesSetGameView_Previews: PreviewProvider {
        static var previews: some View {
            Squiggle().aspectRatio(3/2, contentMode: .fit)
        }
    }
}
