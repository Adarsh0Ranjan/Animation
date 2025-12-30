//
//  ArrowIndicator.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import SwiftUI

struct ArrowIndicator: View {
    let progress: CGFloat
    let pathCalculator: ArcPathCalculating
    
    var body: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(.white)
            .offset(
                x: pathCalculator.xPosition(for: progress),
                y: pathCalculator.yPosition(for: progress)
            )
            .opacity(progress > 0 ? 1 : 0)
    }
}
