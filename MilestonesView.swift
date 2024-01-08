//
//  MilestonesView.swift
//  Budget
//
//  Created by Daniel Madjar on 12/27/23.
//

import SwiftUI
import Charts

struct DPoint: Identifiable {
    let id = UUID()
    let date: Date
    let balance: Double
}

struct MilestonesView: View {
    @AppStorage("FirstLaunch") var requestBalance = true
    @AppStorage("Balance") var balance: Double = 0.0
    
    let dataPoints = [
        DPoint(date: Date(), balance: 200),
        DPoint(date: Date(), balance: 150),
        DPoint(date: Date(), balance: 500)
    ]
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Budget Balance")
                        .fontWeight(.bold)
                        .font(.title3)
                    
                    Text(doubleToDollar(balance))
                        .fontWeight(.bold)
                        .font(.title)
                }
                .modifier(BentoBox())
                
                Chart(dataPoints) { point in
                    LineMark(x: .value("Date", point.date), y: .value("Cost", point.balance))
                }
                .modifier(BentoBox())
                .frame(height: 150)
                
                Button {
                    withAnimation {
                        self.requestBalance.toggle()
                    }
                } label: {
                    Text("Test")
                }
            }
            .padding()
            .background(.white)
            .brightness(requestBalance ? -0.25 : 0)
            
            if requestBalance {
                IntroductionPanel(firstLaunch: $requestBalance, balance: $balance)
                    .padding(25)
            }
        }
        
    }
}

struct MilestonesView_Previews: PreviewProvider {
    static var previews: some View {
        MilestonesView()
    }
}
