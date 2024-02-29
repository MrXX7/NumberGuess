//
//  GameFunctions.swift
//  NumberGuess
//
//  Created by Oncu Can on 29.02.2024.
//

import SwiftUI

func resetGame(guess: inout String, feedback: inout [Color], target: inout String, remainingAttempts: inout Int) {
    guess = ""
    feedback = [Color.gray, Color.gray, Color.gray, Color.gray]
    target = String(format: "%04d", Int.random(in: 0..<10000))
    remainingAttempts = 6
}
