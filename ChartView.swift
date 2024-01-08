//
//  ChartView.swift
//  Budget
//
//  Created by Daniel Madjar on 1/4/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    let dataPoints: FetchedResults<DataPoint>
    
    var body: some View {
        Chart(dataPoints) { point in
            AreaMark(
                x: .value("Date", point.date ?? Date()),
                yStart: .value("Cost", point.balance),
                yEnd: .value("Cost", 0)
            )
            .foregroundStyle(Color("asparagus").opacity(0.35))
            
            LineMark(x: .value("Date", point.date ?? Date()), y: .value("Cost", point.balance))
                .foregroundStyle(Color("secondaryGreen"))
                .symbol {
                    Circle()
                        .fill(Color("secondaryGreen"))
                        .frame(width: 8)
                }
        }
    }
}
