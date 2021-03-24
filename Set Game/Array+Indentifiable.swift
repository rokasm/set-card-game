//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Rokas Mikelionis on 2021-01-14.
//  Copyright © 2021 Rokas Mikelionis. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
             if self[index].id == matching.id {
                 return index
             }
         }
         return nil
     }
}
