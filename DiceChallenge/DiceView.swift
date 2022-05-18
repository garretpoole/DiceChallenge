//
//  DiceView.swift
//  DiceChallenge
//
//  Created by Garret Poole on 5/17/22.
//

import SwiftUI

struct DiceView: View {
    @State var dice: [Dice]
    @State private var rolling = false
    @Binding var total: Int
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<min(dice.count, 2)) { index in
                    Text("\(dice[index].amount)")
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
                ForEach(min(2, dice.count)..<dice.count) { index in
                    Text("\(dice[index].amount)")
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
        for index in (0..<dice.count) {
            let temp = Int.random(in: 1...dice[index].sides)
            dice[index].amount = temp
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
