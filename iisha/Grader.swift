//
//  Grader.swift
//  iisha
//
//  Created by 張翔 on 2018/12/29.
//  Copyright © 2018 張翔. All rights reserved.
//

import Foundation
import Vision
import CoreML
import UIKit

class Grader {
    private var coreMLModel: VNCoreMLModel!
    private var request: VNCoreMLRequest!
    
    weak var delegate: GraderDelegate?
    
    init(){
        coreMLModel = try! VNCoreMLModel(for: insta().model)
        request = VNCoreMLRequest(model: coreMLModel) { (request, error) in
            guard let observations = request.results as? [VNClassificationObservation] else { return }
            guard let floatScore = observations.filter({ (observation) -> Bool in
                return observation.identifier == "insta"
            }).first?.confidence else {
                return
            }
            let intScore = Int((floatScore * 100).rounded())
            self.delegate?.finish(score: intScore)
        }
    }
    
    func perform(_ image: UIImage) {
        guard let ciImage = CIImage(image: image) else { return }
        let hander = VNImageRequestHandler(ciImage: ciImage, options: [:])
        try? hander.perform([request])
    }
}
