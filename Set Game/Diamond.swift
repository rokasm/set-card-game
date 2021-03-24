//
//  Pie.swift
//  Set Game
//
//  Created by Rokas Mikelionis on 2021-03-22.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import SwiftUI

struct Diamond: Shape {
      
    func path(in rect: CGRect) -> Path {
        let start = CGPoint(x: rect.minX, y: rect.midY)
        let top = CGPoint(x: rect.midX, y: rect.maxY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.minY)
       
        var p = Path()
        p.move(to: start)
        p.addLine(to: top)
        p.addLine(to: right)
        p.addLine(to: bottom)
        
        return p
    }
}
