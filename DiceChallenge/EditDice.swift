//
//  EditDice.swift
//  DiceChallenge
//
//  Created by Garret Poole on 5/17/22.
//

import SwiftUI

struct EditDice: View {
    @Environment(\.dismiss) var dismiss
    @Binding var dice: [Dice]
    @State private var sides = 0
    @State private var possibleSides = [4, 6, 8, 10, 12, 20]
    
    var body: some View {
        NavigationView {
            List {
                if(dice.count < 5) {
                    Section("Add Dice") {
                        Picker("Number of Sides", selection: $sides){
                            ForEach(possibleSides, id: \.self){
                                Text("\($0)")
                            }
                        }
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
                    ForEach(0..<dice.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text("Dice \(index+1)")
                                .font(.headline)
                            Text("\(dice[index].sides) Sides")
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
        dice.remove(atOffsets: offsets)
    }
    
    func addDice() {
        let newDice = Dice(sides: sides, amount: Int.random(in: 1...sides))
        dice.append(newDice)
        sides = 0
    }
}

//struct EditDice_Previews: PreviewProvider {
//    static var previews: some View {
//        EditDice()
//    }
//}
