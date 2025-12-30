//
//  PlaceOrderContent.swift
//  EditorialListAssingment
//
//  Created by Adarsh Ranjan on 24/12/25.
//

import SwiftUI

struct PlaceOrderContent: View {
    let isOrderPlaced: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Text("Place Order")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
        }
        .offset(x: isOrderPlaced ? UIScreen.main.bounds.width : 0)
    }
}
