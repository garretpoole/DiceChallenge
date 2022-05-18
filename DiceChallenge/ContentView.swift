//
//  ContentView.swift
//  DiceChallenge
//
//  Created by Garret Poole on 5/14/22.
//

import SwiftUI

struct ContentView: View {
    @State private var dice = [Dice]()
    @State var total = 0
    @State private var results = [String]()
    @State private var editDice = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
     
                if(dice.isEmpty) {
                    Button {
                        editDice = true
                    } label: {
                        Text("Add Dice")
                            .font(.title)
                            .padding()
                            .background(.red.opacity(0.7))
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                    }
                } else {
                    VStack {
                        if(dice.count < 3) {
                            Spacer()
                        }
                        Text("TOTAL: \(total)")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                        
                        DiceView(dice: dice, total: $total)
                            .padding([.top], 20)
                        
                        Spacer()
                        Spacer()
                    }
                }
            }
            .toolbar {
                Button {
                    editDice = true
                } label: {
                    HStack {
                        Image(systemName: "square.and.pencil")
                        Text("Dice")
                    }
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.7))
                    .clipShape(Capsule())
                }
            }
            .sheet(isPresented: $editDice) {
                EditDice(dice: $dice)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
