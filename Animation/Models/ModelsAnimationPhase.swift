//
//  AnimationPhase.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import Foundation

enum AnimationPhase: Equatable {
    case initial
    case subtotalCollapsed
    case orderPlaced
    case continueShoppingReady
    case complete
    
    var isOrderPlaced: Bool {
        self != .initial
    }
    
    var showOnlyCheckmark: Bool {
        switch self {
        case .continueShoppingReady, .complete:
            return true
        default:
            return false
        }
    }
    
    var showContinueShopping: Bool {
        switch self {
        case .complete:
            return true
        default:
            return false
        }
    }
}
