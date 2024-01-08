//
//  PanelTwo.swift
//  Budget
//
//  Created by Daniel Madjar on 12/31/23.
//

import SwiftUI

struct PanelTwo: View {
    @Binding var panel: Int
    @Binding var realBalance: Double
    @Binding var firstLaunch: Bool
    
    @State var isTyping: Bool = false
    @State var balance: Double = 0.00
    @State var balanceString: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Set Starting Balance")
                .font(.title)
                .fontWeight(.bold)
            
            CostPicker(isTyping: $isTyping, cost: $balance, costString: $balanceString, title: "Balance")
                .frame(height: height * 0.24)
            
            IntroductionPanelButton(panel: $panel, action: {
                self.realBalance = self.balance
                self.firstLaunch = false
                self.panel += 1
            })
                .frame(height: height * 0.08)
        }
        .frame(width: width * 0.84, height: height * 0.36, alignment: .topLeading)
        .modifier(BentoBox())
    }
}

#Preview {
    PanelTwo(panel: .constant(2), realBalance: .constant(0), firstLaunch: .constant(true))
}
