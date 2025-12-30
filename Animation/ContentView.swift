//
//  ContentView.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var coordinator = CheckoutAnimationCoordinator()

    private let layoutConstants = LayoutConstants.default
    private let pathCalculator: ArcPathCalculating = ArcPathCalculator()

    var body: some View {
        CheckoutView(
            coordinator: coordinator,
            layoutConstants: layoutConstants,
            pathCalculator: pathCalculator
        )
    }
}

#Preview {
    ContentView()
}
