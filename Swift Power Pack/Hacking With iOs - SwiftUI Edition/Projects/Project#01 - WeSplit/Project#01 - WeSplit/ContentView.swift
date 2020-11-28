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
    /// Corresponds to the picker selection, which starts at 2. This means that the actual number of people is 2 more than this value.
    @State private var numberOfPeople = 2
    /// The selected tip percentage. For corresponding values, see tipPercentages array
    @State private var tipPercentage = 2
    
    /// Different tip percentages available to select
    let tipPercentages = [10, 15, 20, 25, 0]
    
    /// Computes the total due per person, with tip applied to the check
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount * tipSelection / 100
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave ?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
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

