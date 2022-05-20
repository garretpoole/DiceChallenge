//
//  ContentView.swift
//  DiceChallenge
//
//  Created by Garret Poole on 5/14/22.
//

import SwiftUI

class DiceViewModel: ObservableObject {
    @Published var dice = [Dice]()
}

struct ContentView: View {
    @StateObject var diceModel = DiceViewModel()
    @State var total = 0
    @State private var editDice = false
    //saving results
    @State private var results = [String]()
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedTotals")
    //haptic feedback
    @State private var feedback = UINotificationFeedbackGenerator()
    //for implementing timer showing dice roll
    @State private var rolling = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
                VStack {
                    
                    if(diceModel.dice.isEmpty) {
                        Spacer ()
                        Button {
                            editDice = true
                        } label: {
                            Text("Add Dice")
                                .font(.title)
                                .padding()
                                .background(.red.opacity(0.7))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    } else {
                        Spacer()
                        Text("TOTAL: \(total)")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                        
                        DiceView(diceModel: diceModel, total: $total)
                            .padding([.top, .bottom], 20)
                            .onTapGesture{
                                feedback.notificationOccurred(.success)
                                roll()
                            }
                        
                        if(!rolling) {
                            Text("Tap Dice to Roll!")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .padding([.top])
                        }
                            
                    }
                    
                    NavigationLink {
                        ResultView(results: results)
                    } label: {
                        Text("Previous Rolls")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Spacer()
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
                EditDice(diceModel: diceModel)
            }
            .onAppear(perform: loadData)
        }
    }
    
    func roll() {
        print(diceModel.dice.count)
        total = 0
        var result = ""
        for index in (0..<diceModel.dice.count) {
            let temp = Int.random(in: 1...diceModel.dice[index].sides)
            diceModel.dice[index].amount = temp
            total += temp
            result.append("\(diceModel.dice[index].sides) ")
        }
        result.append(": \(total)")
        results.append(result)
        saveData()
        print("Rolling")
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: savePath)
            results = try JSONDecoder().decode([String].self, from: data)
        } catch {
            //no saved data
            results = []
        }
    }
    
    func saveData() {
        do {
            let data = try JSONEncoder().encode(results)
            //.completeFileProtection ensures files are stored with strong encryption
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
