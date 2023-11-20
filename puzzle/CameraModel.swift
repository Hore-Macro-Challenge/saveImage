//
//  CameraModel.swift
//  puzzle
//
//  Created by Vania on 17/10/23.
//

import Foundation
import AVFoundation
import SwiftUI

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate{
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview : AVCaptureVideoPreviewLayer!
    @Published var isSaved = false
    @Published var picData = Data(count: 0)
    
    func Check(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video){ status in
                if status{self.setUp()}
            }
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    func setUp(){
        
        do{
            self.session.beginConfiguration()
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            let input = try AVCaptureDeviceInput(device: device!)
            
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            if self.session.canAddOutput(output){
                self.session.addOutput(output)
            }
            self.session.commitConfiguration()
            
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func takePic(){
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
            }
            self.session.stopRunning()
        }
    }
    
    func retake(){
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            DispatchQueue.main.async {
                withAnimation{self.isTaken.toggle()}
                self.isSaved = false
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil{
            print("error")
            return
        }
        
        print("bisa")
        guard let imageData = photo.fileDataRepresentation() else{
            print("ini")
            return
        }
        
        
        self.picData = imageData
    }
    
    func savePic(){
        let image = UIImage(data: self.picData)!
        let cgImage: CGImage = image.cgImage!
        let mask = UIImage(named: "facemask")!
        let cgmask: CGImage = mask.cgImage!
        
//        
//        let imageMask = CGImage(maskWidth: cgmask.width,
//                                height: cgmask.height,
//                                bitsPerComponent: cgmask.bitsPerComponent,
//                                bitsPerPixel: cgmask.bitsPerPixel,
//                                bytesPerRow: cgmask.bytesPerRow,
//                                provider: cgmask.dataProvider!, decode: nil, shouldInterpolate: false)
//        
//        let maskedReference = cgImage.masking(cgmask)
        
//        let uimasked = UIImage(cgImage: maskedReference!)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        self.isSaved = true
        
        
    }
    
    
    
}
