//
//  Dice.swift
//  DiceChallenge
//
//  Created by Garret Poole on 5/17/22.
//

import Foundation

struct Dice: Codable, Identifiable {
    let id = UUID()
    let sides: Int
    let amount: Int
}
