//
//  ArcPathCalculator.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import CoreGraphics

protocol ArcPathCalculating {
    func xPosition(for progress: CGFloat) -> CGFloat
    func yPosition(for progress: CGFloat) -> CGFloat
}

struct ArcPathCalculator: ArcPathCalculating {
    private let startX: CGFloat
    private let endX: CGFloat
    private let startY: CGFloat
    private let midY: CGFloat
    private let endY: CGFloat
    private let dropPhaseRatio: CGFloat
    
    init(
        startX: CGFloat = 75,
        endX: CGFloat = 100,
        startY: CGFloat = -22,
        midY: CGFloat = 8,
        endY: CGFloat = 0,
        dropPhaseRatio: CGFloat = 0.6
    ) {
        self.startX = startX
        self.endX = endX
        self.startY = startY
        self.midY = midY
        self.endY = endY
        self.dropPhaseRatio = dropPhaseRatio
    }
    
    func xPosition(for progress: CGFloat) -> CGFloat {
        startX + (endX - startX) * progress
    }
    
    func yPosition(for progress: CGFloat) -> CGFloat {
        if progress < dropPhaseRatio {
            let dropProgress = progress / dropPhaseRatio
            return startY + (midY - startY) * dropProgress * dropProgress
        } else {
            let riseProgress = (progress - dropPhaseRatio) / (1 - dropPhaseRatio)
            return midY + (endY - midY) * riseProgress
        }
    }
}
