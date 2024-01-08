//
//  CustomNavBar.swift
//  Budget
//
//  Created by Daniel Madjar on 12/31/23.
//

import SwiftUI

struct CustomNavBar: View {
    @Environment(\.editMode) var editMode
    
    @Binding var usingListView: Bool
    @Binding var search: String
    @Binding var isEditing: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                
                Button {
                    if self.editMode?.wrappedValue == .inactive {
                        withAnimation(.easeInOut) {
                            self.isEditing = true
                            self.editMode?.wrappedValue = .active
                        }
                    } else {
                        withAnimation(.easeInOut) {
                            self.isEditing = false
                            self.editMode?.wrappedValue = .inactive
                        }
                    }
                } label: {
                    if editMode?.wrappedValue == .active {
                        Text("Done")
                    } else {
                        Text("Edit")
                    }
                }
                
                Menu {
                    Button("List", action: {
                        self.usingListView = true
                    })
                    
                    Button("Card", action: {
                        self.usingListView = false
                    })
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                }
            }
            
            HStack(spacing: 5) {
                Image(systemName: "leaf.fill")
                    .renderingMode(.template)
                    .foregroundStyle(Color("secondaryGreen"))
                    .font(.largeTitle.weight(.bold))
                    .flipsForRightToLeftLayoutDirection(true)
                
                Text("My Funds")
                    .font(.largeTitle.weight(.bold))
                
                Spacer()
            }
            
            Text(Date.now.formatted(date: .long, time: .omitted))
                .font(.title3.weight(.semibold))
                .foregroundStyle(.secondary)
            
            CustomSearchBar(search: $search)
        }
    }
}

#Preview {
    CustomNavBar(usingListView: .constant(true), search: .constant(""), isEditing: .constant(false))
}
