//
//  OrderPlacedContent.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import SwiftUI

struct OrderPlacedContent: View {
    let isOrderPlaced: Bool
    let showOnlyCheckmark: Bool
    let showContinueShopping: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            if !showOnlyCheckmark {
                Text("Order placed")
                    .font(.system(size: 16, weight: .medium))
                    .opacity(showOnlyCheckmark ? 0 : 1)
            }
            Image(systemName: "checkmark.circle")
                .font(.system(size: 18, weight: .regular))
        }
        .offset(x: isOrderPlaced ? 0 : -UIScreen.main.bounds.width)
        .offset(y: showContinueShopping ? -44 : 0)
    }
}
