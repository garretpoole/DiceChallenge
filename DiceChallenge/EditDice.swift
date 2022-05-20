//
//  EditDice.swift
//  DiceChallenge
//
//  Created by Garret Poole on 5/17/22.
//

import SwiftUI

struct EditDice: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var diceModel: DiceViewModel
    @State private var sides = 0
    @State private var possibleSides = [4, 6, 8, 10, 12, 20]
    
    var body: some View {
        NavigationView {
            List {
                if(diceModel.dice.count < 5) {
                    Section("Add Dice") {
                        Text("Number of Sides")
                        Picker("Number of Sides", selection: $sides){
                            ForEach(possibleSides, id: \.self){
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        Button("Add Dice", action: addDice)
                            .disabled(sides == 0)
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text("Max of 5 Dice")
                            .font(.headline)
                        Text("Remove Dice to Add New Ones")
                    }
                }
                
                Section {
                    ForEach(0..<diceModel.dice.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text("Dice \(index+1)")
                                .font(.headline)
                            Text("\(diceModel.dice[index].sides) Sides")
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeDice)
                }
            }
            .navigationTitle("Edit Dice")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
        }
    }
    
    func done() {
        dismiss()
    }
    
    func removeDice(at offsets: IndexSet) {
        diceModel.dice.remove(atOffsets: offsets)
    }
    
    func addDice() {
        let newDice = Dice(sides: sides, amount: Int.random(in: 1...sides))
        diceModel.dice.append(newDice)
    }
}

//struct EditDice_Previews: PreviewProvider {
//    static var previews: some View {
//        EditDice()
//    }
//}
