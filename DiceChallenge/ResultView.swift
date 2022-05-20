//
//  ResultView.swift
//  DiceChallenge
//
//  Created by Garret Poole on 5/20/22.
//

import SwiftUI

struct ResultView: View {
    let results: [String]
    
    var body: some View {
        List {
            ForEach(results, id: \.self) { result in
                VStack(alignment: .leading){
                    Text("\(result.components(separatedBy: ":")[1])")
                        .font(.title)
                    Text("Dice: \(result.components(separatedBy: ":")[0])")
                        .font(.headline)
                }
            }
            .navigationTitle("Previous Rolls")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(results: ["2 2 2: 6", "4 6 6: 13"])
    }
}
