//
//  CheckoutAnimationCoordinator.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import SwiftUI
import Combine

@MainActor
final class CheckoutAnimationCoordinator: ObservableObject {
    @Published private(set) var isOrderPlaced = false
    @Published private(set) var showOnlyCheckmark = false
    @Published private(set) var showContinueShopping = false
    @Published private(set) var arrowProgress: CGFloat = 0.0
    
    private let configuration: AnimationConfiguration
    private var animationTask: Task<Void, Never>?
    
    init(configuration: AnimationConfiguration = .default) {
        self.configuration = configuration
    }
    
    func startAnimation() {
        animationTask?.cancel()
        
        animationTask = Task { @MainActor in
            await executeAnimationSequence()
        }
    }
    
    func reset() {
        animationTask?.cancel()
        
        withAnimation(.easeInOut(duration: 0.3)) {
            isOrderPlaced = false
            showOnlyCheckmark = false
            showContinueShopping = false
            arrowProgress = 0.0
        }
    }
    
    private func executeAnimationSequence() async {
        withAnimation(.easeInOut(duration: configuration.phase1Duration)) {
            isOrderPlaced = true
        }
        
        try? await Task.sleep(for: .seconds(configuration.phase2Start))
        withAnimation(.easeInOut(duration: configuration.phase2Duration)) {
            showOnlyCheckmark = true
        }
        
        try? await Task.sleep(for: .seconds(configuration.phase2Duration + configuration.phase2Delay))
        withAnimation(.easeInOut(duration: configuration.phase3Duration)) {
            showContinueShopping = true
        }
        
        try? await Task.sleep(for: .seconds(configuration.phase3Duration + configuration.phase3Delay))
        withAnimation(.linear(duration: configuration.phase4Duration)) {
            arrowProgress = 1.0
        }
    }
}
