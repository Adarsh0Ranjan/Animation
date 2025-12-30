//
//  ContinueShoppingContent.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import SwiftUI

struct ContinueShoppingContent: View {
    let showContinueShopping: Bool
    
    var body: some View {
        Text("Continue Shopping")
            .font(.system(size: 20, weight: .medium))
            .foregroundColor(.white)
            .offset(y: showContinueShopping ? 0 : 44)
    }
}
