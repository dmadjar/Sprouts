//
//  MainView.swift
//  Budget
//
//  Created by Daniel Madjar on 12/27/23.
//

import SwiftUI

struct MainView: View {
    @FetchRequest(sortDescriptors: []) private var myFunds: FetchedResults<FundEntity>
    
    var body: some View {
        TabView {
            FundsView()
                .tabItem {
                    Label("My Funds", systemImage: "creditcard")
                }
            
            MilestonesView()
                .tabItem {
                    Label("Milestones", systemImage: "chart.line.uptrend.xyaxis")
                }
            
            MilestonesView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .tint(.black)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
