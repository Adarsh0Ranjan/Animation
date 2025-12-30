//
//  ContentView.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import SwiftUI

struct ContentView: View {
    private let subtotalTopPadding: CGFloat = 24
    private let subtotalBottomPadding: CGFloat = 24
    private let collapsedTopPadding: CGFloat = 16
    private let subtotalTextHeight: CGFloat = 18
    
    private enum AnimationTiming {
        static let phase1Duration: Double = 0.8
        static let phase1Delay: Double = 0.5
        static let phase2Duration: Double = 0.6
        static let phase2Delay: Double = 0.5
        static let phase3Duration: Double = 0.8
        static let phase3Delay: Double = 0.3
        static let phase4Duration: Double = 0.6
        static var phase2Start: Double {
            phase1Duration + phase1Delay
        }
        
        static var phase3Start: Double {
            phase2Start + phase2Duration + phase2Delay
        }
        
        static var phase4Start: Double {
            phase3Start + phase3Duration + phase3Delay
        }
    }

    private var initialSpacerHeight: CGFloat {
        subtotalTopPadding + subtotalBottomPadding + subtotalTextHeight
    }

    private var slideDistance: CGFloat {
        initialSpacerHeight - collapsedTopPadding
    }

    @State private var isOrderPlaced = false
    @State private var showOnlyCheckmark = false
    @State private var showContinueShopping = false
    @State private var arrowProgress: CGFloat = 0.0
    
    private func arrowXPosition(progress: CGFloat) -> CGFloat {
        let startX: CGFloat = 75
        let endX: CGFloat = 100
        
        return startX + (endX - startX) * progress
    }
    
    private func arrowYPosition(progress: CGFloat) -> CGFloat {
        let startY: CGFloat = -22
        let midY: CGFloat = 8
        let endY: CGFloat = 0
        
        if progress < 0.6 {
            let dropProgress = progress / 0.6
            return startY + (midY - startY) * dropProgress * dropProgress
        } else {
            let riseProgress = (progress - 0.6) / 0.4
            return midY + (endY - midY) * riseProgress
        }
    }

    private func startAnimationSequence() {
        Task { @MainActor in
            withAnimation(.easeInOut(duration: AnimationTiming.phase1Duration)) {
                isOrderPlaced = true
            }
            
            try? await Task.sleep(for: .seconds(AnimationTiming.phase2Start))
            withAnimation(.easeInOut(duration: AnimationTiming.phase2Duration)) {
                showOnlyCheckmark = true
            }
            
            try? await Task.sleep(for: .seconds(AnimationTiming.phase2Duration + AnimationTiming.phase2Delay))
            withAnimation(.easeInOut(duration: AnimationTiming.phase3Duration)) {
                showContinueShopping = true
            }
            
            try? await Task.sleep(for: .seconds(AnimationTiming.phase3Duration + AnimationTiming.phase3Delay))
            withAnimation(.linear(duration: AnimationTiming.phase4Duration)) {
                arrowProgress = 1.0
            }
        }
    }

    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.95, blue: 0.95)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Spacer()
                    
                    if showContinueShopping {
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.gray.opacity(0.15))
                                    .frame(width: 120, height: 120)
                                
                                Image(systemName: "checkmark")
                                    .font(.system(size: 50, weight: .medium))
                                    .foregroundColor(.gray)
                            }
                            .padding(.top, 40)
                            
                            VStack(spacing: 12) {
                                Text("Thank you, your order has been submitted")
                                    .font(.system(size: 28, weight: .semibold))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                
                                Text("We've received your order and our team is preparing your pieces. You'll get an update soon.")
                                    .font(.system(size: 16, weight: .regular))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.black.opacity(0.6))
                                    .padding(.horizontal, 40)
                            }
                            .padding(.bottom, 40)
                        }
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom).combined(with: .opacity),
                            removal: .move(edge: .bottom).combined(with: .opacity)
                        ))
                    }
                }
                .clipped()

                VStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.black.opacity(0.1))
                        .frame(height: 1)

                    ZStack(alignment: .top) {
                        HStack {
                            Text("Subtotal")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(Color.black.opacity(0.6))

                            Spacer()

                            Text("$2,636")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color.black.opacity(0.6))
                        }
                        .padding(.horizontal, 32)
                        .padding(.top, subtotalTopPadding)
                        .padding(.bottom, subtotalBottomPadding)
                        .offset(y: isOrderPlaced ? slideDistance : 0)
                    }
                    .frame(height: isOrderPlaced ? collapsedTopPadding : initialSpacerHeight)
                    .clipped()

                    AnimatedCheckoutButton(
                        isOrderPlaced: $isOrderPlaced,
                        showOnlyCheckmark: $showOnlyCheckmark,
                        showContinueShopping: $showContinueShopping,
                        arrowProgress: $arrowProgress,
                        onTap: startAnimationSequence,
                        arrowXPosition: arrowXPosition,
                        arrowYPosition: arrowYPosition
                    )
                }
            }
        }
    }
}

struct AnimatedCheckoutButton: View {
    @Binding var isOrderPlaced: Bool
    @Binding var showOnlyCheckmark: Bool
    @Binding var showContinueShopping: Bool
    @Binding var arrowProgress: CGFloat
    
    let onTap: () -> Void
    let arrowXPosition: (CGFloat) -> CGFloat
    let arrowYPosition: (CGFloat) -> CGFloat
    
    var body: some View {
        Button(action: onTap) {
            GeometryReader { geometry in
                ZStack {
                    HStack(spacing: 8) {
                        Text("Place Order")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .frame(width: geometry.size.width, height: 44)
                    .offset(x: isOrderPlaced ? geometry.size.width : 0)

                    HStack(spacing: 8) {
                        if !showOnlyCheckmark {
                            Text("Order placed")
                                .font(.system(size: 16, weight: .medium))
                                .opacity(showOnlyCheckmark ? 0 : 1)
                        }
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 18, weight: .regular))
                    }
                    .frame(width: geometry.size.width, height: 44)
                    .offset(x: isOrderPlaced ? 0 : -geometry.size.width)
                    .offset(y: showContinueShopping ? -44 : 0)
                    
                    Text("Continue Shopping")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width, height: 44)
                        .offset(y: showContinueShopping ? 0 : 44)
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .offset(
                            x: arrowXPosition(arrowProgress),
                            y: arrowYPosition(arrowProgress)
                        )
                        .opacity(arrowProgress > 0 ? 1 : 0)
                }
                .clipped()
            }
            .frame(height: 44)
            .background(
                showContinueShopping ? Color.black : (isOrderPlaced ? Color.white : Color.black)
            )
            .overlay {
                Rectangle()
                    .stroke(Color.black, lineWidth: (isOrderPlaced && !showContinueShopping) ? 1 : 0)
            }
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 32)
        .padding(.bottom, 32)
    }
}

#Preview {
    ContentView()
}
