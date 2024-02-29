//
//  ContentView.swift
//  NumberGuess
//
//  Created by Oncu Can on 28.02.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var guess = ""
    @State private var feedback = [Color.gray, Color.gray, Color.gray, Color.gray]
    @State private var target = String(format: "%04d", Int.random(in: 0..<10000))
    @State private var animate = false
    @State private var remainingAttempts = 6 // Kullanıcının kalan deneme hakkı

    var body: some View {
        VStack {
            Text("Enter the 4-digit number you guessed:")
                .font(.headline)
            TextField("Guess", text: $guess)
                .padding()
                .font(.title)
                .keyboardType(.decimalPad)
                .onReceive(guess.publisher.collect()) { // Kullanıcının girdisi doğrulamak için
                    let filtered = $0.filter { "0123456789".contains($0) } // Sadece rakamları kabul et
                    if filtered.count > 4 { // Sadece 4 rakam kabul edelim
                        self.guess = String(filtered.prefix(4))
                    } else {
                        self.guess = String(filtered)
                    }
                }
            Button("Guess") {
                withAnimation {
                    checkGuess()
                    remainingAttempts -= 1 // Her tahminde kalan hakkı azalt
                    if remainingAttempts == 0 { // Eğer kalan hak 0 ise resetGame() fonksiyonunu çağır
                        resetGame()
                    }
                }
            }
            Button("Reset") {
                withAnimation {
                    resetGame()
                }
            }
            Text("Remaining Attempts: \(remainingAttempts)") // Kalan deneme hakkını göster
                .font(.headline)
                .padding(.top, 10)
            HStack {
                ForEach(feedback, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 40, height: 40)
                        .scaleEffect(animate ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.5))
                }
            }
            if feedback.allSatisfy({ $0 == Color.green }) {
                Text("Congratulations! You guessed it right.")
                    .foregroundColor(.green)
                    .font(.headline)
                    .padding()
            } else if remainingAttempts == 0 {
                Text("You've used all your attempts. The correct answer was \(target).")
                    .foregroundColor(.red)
                    .font(.headline)
                    .padding()
            }
        }
        .padding()
        .onAppear {
            animate = true
        }
    }
    
    func checkGuess() {
        var reds = 0
        var yellows = 0
        let guessArray = Array(guess)
        let targetArray = Array(target)
        
        for i in 0..<4 {
            if guessArray[i] == targetArray[i] {
                reds += 1
                feedback[i] = Color.green
            } else if targetArray.contains(guessArray[i]) {
                yellows += 1
                feedback[i] = Color.yellow
            } else {
                feedback[i] = Color.red
            }
        }
    }
    
    func resetGame() {
        guess = ""
        feedback = [Color.gray, Color.gray, Color.gray, Color.gray]
        target = String(format: "%04d", Int.random(in: 0..<10000))
        remainingAttempts = 6 // Oyun sıfırlandığında deneme hakkını tekrar 6 yap
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}






