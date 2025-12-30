//
//  SubtotalRow.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import SwiftUI

struct SubtotalRow: View {
    let subtotal: String
    let isOrderPlaced: Bool
    let slideDistance: CGFloat
    let constants: LayoutConstants
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack {
                Text("Subtotal")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(Color.black.opacity(0.6))
                
                Spacer()
                
                Text(subtotal)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color.black.opacity(0.6))
            }
            .padding(.horizontal, 32)
            .padding(.top, constants.subtotalTopPadding)
            .padding(.bottom, constants.subtotalBottomPadding)
            .offset(y: isOrderPlaced ? slideDistance : 0)
        }
        .frame(height: isOrderPlaced ? constants.collapsedTopPadding : constants.initialSpacerHeight)
        .clipped()
    }
}
