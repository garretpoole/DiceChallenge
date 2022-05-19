//
//  DiceView.swift
//  DiceChallenge
//
//  Created by Garret Poole on 5/17/22.
//

import SwiftUI

struct DiceView: View {
    @ObservedObject var diceModel: DiceViewModel
    @State private var rolling = false
    @Binding var total: Int
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<min(diceModel.dice.count, 2)) { index in
                    Text("\(diceModel.dice[index].amount)")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.white)
                        .background(.red.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .scaleEffect(1.5)
                        .padding()
                }
            }
            .padding(.vertical)
            
            HStack {
                ForEach(min(2, diceModel.dice.count)..<diceModel.dice.count) { index in
                    Text("\(diceModel.dice[index].amount)")
                        .font(.largeTitle)
                        .padding()
                        .foregroundColor(.white)
                        .background(.red.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .scaleEffect(1.5)
                        .padding()
                }
            }
            .padding(.bottom)
            
            if(!rolling) {
                Text("Tap to Roll!")
                    .font(.title)
                    .foregroundColor(.white )
            }
        }
        .onTapGesture(perform: roll)
    }
    func roll() {
        total = 0
        for index in (0..<diceModel.dice.count) {
            let temp = Int.random(in: 1...diceModel.dice[index].sides)
            diceModel.dice[index].amount = temp
            total += temp
        }
        print("Rolling")
    }
}

//struct DiceView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiceView()
//    }
//}
