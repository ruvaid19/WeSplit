//
//  ContentView.swift
//  WeSplit
//
//  Created by Ruvaid on 29/07/26.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }

    var checkTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection

        return checkAmount + tipValue
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color(red: 0.92, green: 0.99, blue: 0.95), // light mint highlight for freshness
                        Color(red: 0.55, green: 0.88, blue: 0.68), // fresh green mid
                        Color(red: 0.22, green: 0.68, blue: 0.40), // balanced emerald
                        Color(red: 0.12, green: 0.48, blue: 0.28)  // supportive deep green for depth
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                Form {
                    Section {
                        TextField(
                            "Amount",
                            value: $checkAmount,
                            format: .currency(
                                code: Locale.current.currency?.identifier ?? "USD"
                            )
                        )
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                    }

                    Section("How much do you want to tip?") {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(0..<101) {
                                Text($0, format: .percent)
                            }
                        }
                    }

                    Section("Amount per person") {
                        Text(
                            totalPerPerson,
                            format: .currency(
                                code: Locale.current.currency?.identifier ?? "USD"
                            )
                        )
                        .font(.headline)
                        .fontWeight(.semibold)
                    }

                    Section("Total check amount") {
                        Text(
                            checkTotal,
                            format: .currency(
                                code: Locale.current.currency?.identifier ?? "USD"
                            )
                        )
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(tipPercentage == 0 ? .red : .primary)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(.ultraThinMaterial)
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
