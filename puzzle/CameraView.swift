//
//  CameraView.swift
//  puzzle
//
//  Created by Vania on 17/10/23.
//

import Foundation
import SwiftUI

struct CameraView: View {
    
    @StateObject var camera = CameraModel()
    let faceShape = FaceShape()
    
    var body: some View{
        ZStack{
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            VStack
            {
                if camera.isTaken
                {
                    HStack
                    {
                        Spacer()
                        Button(action: camera.retake, label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                            
                        })
                        .padding(.trailing)
                        
                    }
                }
                
                Spacer()
                HStack
                {
                    if camera.isTaken{
                        Button(action: {if !camera.isSaved{camera.savePic()}}, label: {
                            Text(camera.isSaved ? "Saved" : "Save")
                                .foregroundStyle(Color.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                                .clipShape(Capsule())
                            
                        })
                        .padding(.leading)
                        
                        Spacer()
                        
                    }
                    else{
                        Button(action: {camera.takePic()}, label: {
                            ZStack
                            {
                                Circle().fill(Color.white)
                                    .frame(width: 65, height: 65)
                                Circle().stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        })
                    }
                }
                .frame(height: 75)
            }
        }
        .onAppear(perform: {
            camera.Check()
        })
    }
    
}

#Preview {
    CameraView()
}

