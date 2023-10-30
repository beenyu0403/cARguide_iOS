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

class Coordinator: NSObject {
    var arContainer: ARViewContainer
    
    init(_ container: ARViewContainer) {
        self.arContainer = container
    }
    
    // MARK: - Add textbox when (tap) action
    // 나중에 이미지 인식시 추가될 수 있도록 변경
    @objc func isViewTapped(gesture: UITapGestureRecognizer) {
        guard let arView = gesture.view as? ARView
        else { return }
        
        // get tap location
        let tapPosition = gesture.location(in: arView)
        
        // Convert tap position to AR world
        if let raycastQuery = arView.makeRaycastQuery(
            from: tapPosition, allowing: .estimatedPlane,
            alignment: .any),
        let raycastResult = arView.session.raycast(raycastQuery).first {
            let anchor = AnchorEntity(world: raycastResult.worldTransform)
            arView.scene.addAnchor(anchor)
            
            // Mesh
            // To Do: Text string에 model에서 얻은 label 받기
            let textMesh = MeshResource.generateText(
                "Button name",
                extrusionDepth: 0.01,
                font: .systemFont(ofSize: 0.02),
                containerFrame: .zero,
                alignment: .center,
                lineBreakMode: .byTruncatingMiddle
            )
            // To Do: Background 처리 방식 고민해보자
            let backgroundMesh = MeshResource.generateBox(size: 0.05)
            
            // Mesh to Entity
            let textEntiy = ModelEntity(
                mesh: textMesh,
                materials: [SimpleMaterial(color: .black, isMetallic: false)]
            )
            let backgroundEntity = ModelEntity(
                mesh: backgroundMesh,
                materials: [SimpleMaterial(color: .white, isMetallic: false)]
            )
            
            // Add Entity to ARView
            anchor.addChild(textEntiy)
            anchor.addChild(backgroundEntity)
            arView.scene.addAnchor(anchor)
        }
        
        print("AR DEBUG: Tag mesh add")
    }
}
