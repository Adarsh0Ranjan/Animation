//
//  ThankYouMessage.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import SwiftUI

struct ThankYouMessage: View {
    var body: some View {
        VStack(spacing: 16) {
            CheckmarkIcon()
            
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

private struct CheckmarkIcon: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.15))
                .frame(width: 120, height: 120)
            
            Image(systemName: "checkmark")
                .font(.system(size: 50, weight: .medium))
                .foregroundColor(.gray)
        }
        .padding(.top, 40)
    }
}
