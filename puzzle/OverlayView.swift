//
//  OverlayView.swift
//  puzzle
//
//  Created by Vania on 18/10/23.
//

import Foundation
import SwiftUI

struct OverlayView: View {
    var body: some View {
        ZStack
        {
            Color.black
                .ignoresSafeArea(.all, edges: .all)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            
            Rectangle()
                .frame(width: 200, height: 200)
                .position(x: 200, y: 100)
                .border(Color.white, width: 5)
        }
    }
}

#Preview {
    OverlayView()
}
