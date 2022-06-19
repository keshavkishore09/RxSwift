//
//  FilterService.swift
//  Camera Filter
//
//  Created by Keshav Kishore on 19/06/22.
//

import UIKit
import CoreImage
import RxSwift


class FilterService {
    private var context: CIContext
    
    
    init() {
        self.context = CIContext()
    }
    
    
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) { filteredImage in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        }
    }
    
    
    
    func applyFilter(to inputImage: UIImage, completion: @escaping((UIImage) -> ())) {
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(4.0, forKey:   kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage) {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgImg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                let processedImage = UIImage(cgImage: cgImg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
        
        
    }
}
