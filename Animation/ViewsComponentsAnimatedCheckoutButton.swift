//
//  AnimatedCheckoutButton.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import SwiftUI

struct AnimatedCheckoutButton: View {
    @Binding var isOrderPlaced: Bool
    @Binding var showOnlyCheckmark: Bool
    @Binding var showContinueShopping: Bool
    @Binding var arrowProgress: CGFloat
    
    let onTap: () -> Void
    let pathCalculator: ArcPathCalculating
    
    init(
        isOrderPlaced: Binding<Bool>,
        showOnlyCheckmark: Binding<Bool>,
        showContinueShopping: Binding<Bool>,
        arrowProgress: Binding<CGFloat>,
        onTap: @escaping () -> Void,
        pathCalculator: ArcPathCalculating = ArcPathCalculator()
    ) {
        self._isOrderPlaced = isOrderPlaced
        self._showOnlyCheckmark = showOnlyCheckmark
        self._showContinueShopping = showContinueShopping
        self._arrowProgress = arrowProgress
        self.onTap = onTap
        self.pathCalculator = pathCalculator
    }
    
    var body: some View {
        Button(action: onTap) {
            GeometryReader { geometry in
                ZStack {
                    PlaceOrderContent(isOrderPlaced: isOrderPlaced)
                        .frame(width: geometry.size.width, height: 44)
                    
                    OrderPlacedContent(
                        isOrderPlaced: isOrderPlaced,
                        showOnlyCheckmark: showOnlyCheckmark,
                        showContinueShopping: showContinueShopping
                    )
                    .frame(width: geometry.size.width, height: 44)
                    
                    ContinueShoppingContent(showContinueShopping: showContinueShopping)
                        .frame(width: geometry.size.width, height: 44)
                    
                    ArrowIndicator(
                        progress: arrowProgress,
                        pathCalculator: pathCalculator
                    )
                }
                .clipped()
            }
            .frame(height: 44)
            .background(buttonBackgroundColor)
            .overlay {
                Rectangle()
                    .stroke(Color.black, lineWidth: buttonBorderWidth)
            }
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 32)
        .padding(.bottom, 32)
    }
    
    private var buttonBackgroundColor: Color {
        showContinueShopping ? .black : (isOrderPlaced ? .white : .black)
    }
    
    private var buttonBorderWidth: CGFloat {
        (isOrderPlaced && !showContinueShopping) ? 1 : 0
    }
}
