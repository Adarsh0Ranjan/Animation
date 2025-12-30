//
//  CheckoutFooterView.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import SwiftUI

struct CheckoutFooterView: View {
    @Binding var isOrderPlaced: Bool
    @Binding var showOnlyCheckmark: Bool
    @Binding var showContinueShopping: Bool
    @Binding var arrowProgress: CGFloat
    
    let subtotal: String
    let constants: LayoutConstants
    let pathCalculator: ArcPathCalculating
    let onPlaceOrder: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.black.opacity(0.1))
                .frame(height: 1)
            
            SubtotalRow(
                subtotal: subtotal,
                isOrderPlaced: isOrderPlaced,
                slideDistance: constants.slideDistance,
                constants: constants
            )
            
            AnimatedCheckoutButton(
                isOrderPlaced: $isOrderPlaced,
                showOnlyCheckmark: $showOnlyCheckmark,
                showContinueShopping: $showContinueShopping,
                arrowProgress: $arrowProgress,
                onTap: onPlaceOrder,
                pathCalculator: pathCalculator
            )
        }
    }
}
