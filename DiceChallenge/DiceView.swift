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
    
    @State private var twoRowGrid = [GridItem(.flexible(minimum: 60), spacing: 75), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            LazyHGrid(rows: twoRowGrid, alignment: .center) {
                ForEach(diceModel.dice) { dice in
                    ZStack {
                        Rectangle()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.red.opacity(0.8))
                            .cornerRadius(16)
                        Text("\(dice.amount)")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .scaleEffect(1.5)
                    }
                }
            }
            
//            if(!rolling) {
//                Text("Tap to Roll!")
//                    .font(.title)
//                    .foregroundColor(.white )
//            }
        }
//        .onTapGesture(perform: roll)
    }
//    func roll() {
//        print(diceModel.dice.count)
//        total = 0
//        for index in (0..<diceModel.dice.count) {
//            let temp = Int.random(in: 1...diceModel.dice[index].sides)
//            diceModel.dice[index].amount = temp
//            total += temp
//        }
//        print("Rolling")
//    }
}

//struct DiceView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiceView()
//    }
//}
