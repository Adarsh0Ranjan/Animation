//
//  ContentView.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Layout Constants
    private let subtotalTopPadding: CGFloat = 24
    private let subtotalBottomPadding: CGFloat = 24
    private let collapsedTopPadding: CGFloat = 16
    private let subtotalTextHeight: CGFloat = 18
    private let animationDuration: Double = 0.8

    // MARK: - Computed Properties
    private var initialSpacerHeight: CGFloat {
        subtotalTopPadding + subtotalBottomPadding + subtotalTextHeight
    }

    private var slideDistance: CGFloat {
        initialSpacerHeight - collapsedTopPadding
    }

    // MARK: - State
    @State private var isOrderPlaced = false
    @State private var showOnlyCheckmark = false
    @State private var showContinueShopping = false

    // MARK: - Body
    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.95, blue: 0.95)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Content above divider that scrolls up - CLIPPED so only visible above divider
                VStack(spacing: 0) {
                    Spacer()
                    
                    // Thank you message - slides up to reveal from above divider
                    if showContinueShopping {
                        VStack(spacing: 16) {
                            // Checkmark icon
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
                .clipped() // Clip content so it's only visible above the divider

                // Footer section
                VStack(spacing: 0) {
                    // Divider - stays in place
                    Rectangle()
                        .fill(Color.black.opacity(0.1))
                        .frame(height: 1)

                    ZStack(alignment: .top) {
                        // Subtotal row - will slide down off screen
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
                    .clipped() // Hide overflow when subtotal slides down

                    // Place Order button with animation
                    Button {
                        withAnimation(.easeInOut(duration: animationDuration)) {
                            isOrderPlaced = true
                        }

                        // Phase 2: Show only checkmark after a delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration + 0.5) {
                            withAnimation(.easeInOut(duration: 0.6)) {
                                showOnlyCheckmark = true
                            }
                        }
                        
                        // Phase 3: Show "Continue Shopping" after another delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration + 0.5 + 0.6 + 0.5) {
                            withAnimation(.easeInOut(duration: animationDuration)) {
                                showContinueShopping = true
                            }
                        }
                    } label: {
                        GeometryReader { geometry in
                            ZStack {
                                // Phase 1 content: "Place Order" sliding out to right
                                HStack(spacing: 8) {
                                    Text("Place Order")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .frame(width: geometry.size.width, height: 44)
                                .offset(x: isOrderPlaced ? geometry.size.width : 0)

                                // Phase 2 content: "Order placed" + checkmark sliding in from left
                                HStack(spacing: 8) {
                                    if !showOnlyCheckmark {
                                        Text("Order placed")
                                            .font(.system(size: 16, weight: .medium))
                                            .opacity(showOnlyCheckmark ? 0 : 1)
                                    }

                                    Image(systemName: "checkmark.circle")
                                        .font(.system(size: 18, weight: .regular))
                                }
                                .foregroundColor(Color.black.opacity(0.6))
                                .frame(width: geometry.size.width, height: 44)
                                .offset(x: isOrderPlaced ? 0 : -geometry.size.width)
                                .offset(y: showContinueShopping ? -44 : 0) // Slide up when Continue Shopping appears
                                
                                // Phase 3 content: "Continue Shopping" sliding up from bottom
                                HStack(spacing: 8) {
                                    Text("Continue Shopping")
                                        .font(.system(size: 20, weight: .medium))
                                        .foregroundColor(.white)
                                }
                                .frame(width: geometry.size.width, height: 44)
                                .offset(y: showContinueShopping ? 0 : 44) // Slide up from below
                            }
                            .clipped() // Clip the sliding content
                        }
                        .frame(height: 44)
                        // Animated background color transition
                        .background(
                            showContinueShopping ? Color.black : (isOrderPlaced ? Color.white : Color.black)
                        )
                        // Animated border
                        .overlay {
                            Rectangle()
                                .stroke(Color.black, lineWidth: (isOrderPlaced && !showContinueShopping) ? 1 : 0)
                        }
                    }
                    .buttonStyle(.plain)
                    //                    .disabled(isOrderPlaced)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
