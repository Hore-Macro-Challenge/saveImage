//
//  FaceShape.swift
//  puzzle
//
//  Created by Vania on 18/10/23.
//

import Foundation
import SwiftUI
import CoreGraphics


struct FaceShape: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let x1 = rect.maxX
        let y1 = rect.maxY
        let x2 = rect.minX
        let y2 = rect.minY
        
        path.move(to: CGPoint(x: x1*5/12, y: y2))
        path.addLine(to: CGPoint(x: x1*7/12, y: y2))
        path.addLine(to: CGPoint(x: x1*5/6, y: y1*1/8))
        path.addLine(to: CGPoint(x: x1, y: y1*3/8))
        path.addLine(to: CGPoint(x: x1, y: y1*4/8))
        path.addLine(to: CGPoint(x: x1*5/6, y: y1*7/8))
        path.addLine(to: CGPoint(x: x1*7/12, y: y1))
        path.addLine(to: CGPoint(x: x1*5/12, y: y1))
        path.addLine(to: CGPoint(x: x1*1/6, y: y1*7/8))
        path.addLine(to: CGPoint(x: x2, y: y1*4/8))
        path.addLine(to: CGPoint(x: x2, y: y1*3/8))
        path.addLine(to: CGPoint(x: x1*1/6, y: y1*1/8))
        path.addLine(to: CGPoint(x: x1*5/12, y: y2))
        path.closeSubpath()
        
        return path
    }
    
    

}

struct FaceShapeView: View {
    var body: some View {
        FaceShape()
            .stroke(Color.black, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            .fill(.black)
            .frame(width: 600, height: 720)
    }
}

#Preview {
    FaceShapeView()
}
