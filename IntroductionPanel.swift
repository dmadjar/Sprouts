//
//  IntroductionPanel.swift
//  Budget
//
//  Created by Daniel Madjar on 12/31/23.
//

import SwiftUI

struct IntroductionPanel: View {
    @Binding var firstLaunch: Bool
    @Binding var balance: Double
    
    @State var panel: Int = 1
    
    var body: some View {
        switch panel {
        case 1:
            PanelOne(firstLaunch: $firstLaunch, panel: $panel)
        case 2:
            PanelTwo(panel: $panel, realBalance: $balance, firstLaunch: $firstLaunch)
        default:
            EmptyView()
        }
    }
}

#Preview {
    IntroductionPanel(firstLaunch: .constant(true), balance: .constant(0))
}
