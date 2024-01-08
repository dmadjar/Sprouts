//
//  FundRow.swift
//  Budget
//
//  Created by Daniel Madjar on 12/26/23.
//

import SwiftUI

struct FundRow: View {
    let name: String
    let money: String
    let isTrendingUp: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.headline)
                    
                    Text("Subtitle")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Text(money)
                
                Image(systemName: isTrendingUp ? "arrow.up.forward.square.fill"
                      : "arrow.down.forward.square.fill")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 20, height: 20)
                    .foregroundColor(isTrendingUp ? Color.green : Color.red)
            }
        }
        .foregroundColor(.black)
    }
}

struct FundRow_Previews: PreviewProvider {
    static var previews: some View {
        FundRow(name: "Furniture", money: "2,532", isTrendingUp: true)
    }
}
