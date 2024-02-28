//
//  ContentView.swift
//  NumberGuess
//
//  Created by Oncu Can on 28.02.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var guess = ""
    @State private var feedback = ""
    let target = String(format: "%04d", Int.random(in: 0..<10000))
    
    var body: some View {
        VStack {
            Text("Tahmin ettiğim 4 haneli sayıyı gir:")
            TextField("Tahmin", text: $guess)
                .padding()
                .keyboardType(.numberPad)
            Button("Tahmin Et") {
                checkGuess()
            }
            Text(feedback)
        }
        .padding()
    }
    
    func checkGuess() {
        var reds = 0
        var yellows = 0
        let guessArray = Array(guess)
        let targetArray = Array(target)
        
        for i in 0..<4 {
            if guessArray[i] == targetArray[i] {
                reds += 1
            } else if targetArray.contains(guessArray[i]) {
                yellows += 1
            }
        }
        
        if reds == 4 {
            feedback = "Tebrikler! Doğru tahmin ettiniz."
        } else {
            feedback = "Kırmızı: \(reds), Sarı: \(yellows)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

