//
//  CheckoutView.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import SwiftUI
import Combine

struct CheckoutView: View {
    @ObservedObject var coordinator: CheckoutAnimationCoordinator
    
    let layoutConstants: LayoutConstants
    let pathCalculator: ArcPathCalculating
    let subtotal: String
    
    init(
        coordinator: CheckoutAnimationCoordinator,
        layoutConstants: LayoutConstants = .default,
        pathCalculator: ArcPathCalculating = ArcPathCalculator(),
        subtotal: String = "$2,636"
    ) {
        self.coordinator = coordinator
        self.layoutConstants = layoutConstants
        self.pathCalculator = pathCalculator
        self.subtotal = subtotal
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.95, blue: 0.95)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                contentSection
                footerSection
            }
        }
    }
    
    private var contentSection: some View {
        VStack(spacing: 0) {
            Spacer()
            
            if coordinator.showContinueShopping {
                ThankYouMessage()
            }
        }
        .clipped()
    }
    
    private var footerSection: some View {
        CheckoutFooterView(
            isOrderPlaced: binding(\.isOrderPlaced),
            showOnlyCheckmark: binding(\.showOnlyCheckmark),
            showContinueShopping: binding(\.showContinueShopping),
            arrowProgress: binding(\.arrowProgress),
            subtotal: subtotal,
            constants: layoutConstants,
            pathCalculator: pathCalculator,
            onPlaceOrder: coordinator.startAnimation
        )
    }
    
    private func binding<T>(_ keyPath: KeyPath<CheckoutAnimationCoordinator, T>) -> Binding<T> {
        Binding(
            get: { coordinator[keyPath: keyPath] },
            set: { _ in }
        )
    }
}
