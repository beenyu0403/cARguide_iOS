//
//  Coordinator.swift
//  ButtonARGuide
//
//  Created by user on 10/14/23.
//  Edited by 송영훈 from 10/25/23.
//

import SwiftUI
import Foundation
import ARKit
import RealityKit


class Coordinator: NSObject {
    var arContainer: ARViewContainer
    init(_ container: ARViewContainer) {
        self.arContainer = container
    }
    
    // MARK: - Add textbox when (tap) action
    // 나중에 이미지 인식시 추가될 수 있도록 변경
    // 추가로 label이 사용자가 보기 편한 방향으로 조정하기
    @objc func isViewTapped(gesture: UITapGestureRecognizer) {
        guard let arView = gesture.view as? ARView
        else { return }
        
        // get tap location
        let tapPosition = gesture.location(in: arView)
        
        // Finding real-world surfaces
        if let raycastQuery = arView.makeRaycastQuery(
            from: tapPosition, allowing: .estimatedPlane,
            alignment: .any),
           let raycastResult = arView.session.raycast(raycastQuery).first {
            let anchor = AnchorEntity(world: raycastResult.worldTransform)
            
            print("AR DEBUG: Touch position Anchored")
            
            let textMesh = MeshResource.generateText(
                "label",
                extrusionDepth: 0.001,
                font: .systemFont(ofSize: 0.02),
                containerFrame: .zero,
                alignment: .center,
                lineBreakMode: .byCharWrapping
            )
            let textMaterial = SimpleMaterial(color: .black, isMetallic: false)
            let textEntity = ModelEntity(mesh: textMesh,materials: [textMaterial])
            
            
            anchor.addChild(textEntity)
            arView.scene.addAnchor(anchor)
        }
    }
}
