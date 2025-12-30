//
//  AnimationConfiguration.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import Foundation

struct AnimationConfiguration {
    let phase1Duration: Double
    let phase1Delay: Double
    let phase2Duration: Double
    let phase2Delay: Double
    let phase3Duration: Double
    let phase3Delay: Double
    let phase4Duration: Double
    
    var phase2Start: Double {
        phase1Duration + phase1Delay
    }
    
    var phase3Start: Double {
        phase2Start + phase2Duration + phase2Delay
    }
    
    var phase4Start: Double {
        phase3Start + phase3Duration + phase3Delay
    }
    
    static let `default` = AnimationConfiguration(
        phase1Duration: 0.8,
        phase1Delay: 0.5,
        phase2Duration: 0.6,
        phase2Delay: 0.5,
        phase3Duration: 0.8,
        phase3Delay: 0.3,
        phase4Duration: 0.6
    )
}
