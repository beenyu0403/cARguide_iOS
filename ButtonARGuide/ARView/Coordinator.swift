//
//  Coordinator.swift
//  ButtonARGuide
//
//  Created by user on 10/14/23.
//  Edited by 송영훈 from 10/25/23.
//

import Foundation
import ARKit
import RealityKit

class Coordinator: NSObject, ARSessionDelegate {

    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        guard let view = self.view else { return }
        
        let tapLocation = recognizer.location(in: view)
        
        view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any)
        if let entity = view.entity(at: tapLocation) as? ModelEntity {
            let material = SimpleMaterial(color: UIColor.random(), isMetallic: true)
            entity.model?.materials = [material]
        }
    }
}
