//
//  SectionHeaderView.swift
//  GroceryApp
//
//  Created by Oğuzhan Bolat on 29.07.2024.
//

import SwiftUI

struct SectionHeaderView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Button {
                // Action in here
            } label: {
                Text("See all")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
        }
        .padding([.leading, .trailing, .top])
        
        
    }
}

#Preview {
    SectionHeaderView(title: "Test")
}
