//
//  ItemRow.swift
//  Budget
//
//  Created by Daniel Madjar on 12/27/23.
//

import SwiftUI

struct ItemRow: View {
    let name: String
    let cost: Double
    let date: Date
    
    let isDeposit: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading) {
                    Text(isDeposit ? "Deposited" : name)
                        .font(.headline)
                    
                    Text(Date.now.formatted(date: .long, time: .omitted))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
//                    Text(date.formatted(.iso8601.year().month().day()))
//                        .font(.subheadline)
                }
                
                Spacer()
                
                Text(doubleToDollar(cost))

                Image(systemName: isDeposit ? "plus.app.fill" : "minus.square.fill")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(isDeposit ? Color("primaryGreen") : Color.red)
            }
        }
        .foregroundColor(.black)
    }
}

#Preview {
    ItemRow(name: "Couch", cost: 2500, date: Date(), isDeposit: false)
}
