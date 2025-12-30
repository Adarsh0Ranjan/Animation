//
//  LayoutConstants.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import Foundation

struct LayoutConstants {
    let subtotalTopPadding: CGFloat
    let subtotalBottomPadding: CGFloat
    let collapsedTopPadding: CGFloat
    let subtotalTextHeight: CGFloat
    
    var initialSpacerHeight: CGFloat {
        subtotalTopPadding + subtotalBottomPadding + subtotalTextHeight
    }
    
    var slideDistance: CGFloat {
        initialSpacerHeight - collapsedTopPadding
    }
    
    static let `default` = LayoutConstants(
        subtotalTopPadding: 24,
        subtotalBottomPadding: 24,
        collapsedTopPadding: 16,
        subtotalTextHeight: 18
    )
}
