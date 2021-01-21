//
//  ContentView.swift
//  Project02 - Guess The Flag
//
//  Created by Arnaud Miguet on 29.11.20.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var rotations = [0.0, 0.0, 0.0]
    @State private var alphas = [1.0, 1.0, 1.0]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text("Score : \(score)")
                }.foregroundColor(.white)
                ForEach(0..<3) { number in
                    Button(action: {
                        flagTapped(number)
                    }) {
                        // Project 03 - Challenge 03
                        FlagImage(imageName: countries[number].lowercased())
                    }
                    .rotationEffect(.degrees(rotations[number]))
                    .opacity(alphas[number])
                }
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            withAnimation {
                rotations[number] = 360
                alphas = [0.25, 0.25, 0.25]
                alphas[number] = 1
            }
        } else {
            scoreTitle = "Wrong, that was the flag of \(countries[number])"
            score -= 1
            withAnimation {
                rotations[correctAnswer] = 360
                alphas = [0.25, 0.25, 0.25]
                alphas[number] = 1
                alphas[correctAnswer] = 1
            }
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        rotations = [0.0, 0.0, 0.0]
        alphas = [1.0, 1.0, 1.0]
        correctAnswer = Int.random(in: 0..<3)
    }
}

struct FlagImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
