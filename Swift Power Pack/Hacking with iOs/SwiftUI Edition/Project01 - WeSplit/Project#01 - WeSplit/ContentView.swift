//
//  ContentView.swift
//  Project#01 - WeSplit
//
//  Created by Arnaud Miguet on 28.11.20.
//

import SwiftUI

struct ContentView: View {
    /// The amount of the check, from the textview
    @State private var checkAmount = ""
    /// The number of people selected to split the checkout into
    ///
    
    /// The number of people to split the check into, two-way binded to the textfield
    @State private var numberOfPeople = ""
    // Replaced with challenge 3 :
    
    /// Corresponds to the picker selection, which starts at 2. This means that the actual number of people is 2 more than this value.
//    @State private var numberOfPeople = 2

    /// The selected tip percentage. For corresponding values, see tipPercentages array
    @State private var tipPercentage = 2
    
    /// Different tip percentages available to select
    let tipPercentages = [10, 15, 20, 25, 0]
    
    /// Computes the total amount due, with tip included
    var totalAmount: Double {
        // Challenge 3 replaced the following line
//        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount * tipSelection / 100
        return orderAmount + tipValue
    }
    
    /// Computes the total due per person based on total amount
    var totalPerPerson: Double {
        let peopleCount = (Double(numberOfPeople) ?? 0) + 2
        return totalAmount / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    // Challenge 3 replaced those lines :
//                    Picker("Number of People", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            Text("\($0) people")
//                        }
//                    }
                    // With the following textfield :
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave ?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total amount (with tip)")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                        // Project 03 Challenge 02 :
                        .foregroundColor(Double(tipPercentages[tipPercentage]) == 0 ? .red : .black)
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro")
    }
}

