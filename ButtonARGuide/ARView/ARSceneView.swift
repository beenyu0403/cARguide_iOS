//
//  ARSceneView.swift
//  ButtonARGuide
//
//  Created by user on 10/14/23.
//  Edited by 송영훈 from 10/25/23.
//

import SwiftUI

import ARKit
import RealityKit


struct ARSceneView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    // var model
    
    // MARK: - Create UIView(UIKit) & initialize
    func makeUIView(context: Context) -> ARView {
        print("AR DUBUG: Make UIView")
        
        // Screen size : 1179*2556(iPhone 15 pro)
        let arView = ARView(frame: .zero)
        print("AR DEBUG: ARView appear")
        
        // Connect ARView with UIKit
        // Help control event & networking
        context.coordinator.view = arView
        arView.session.delegate = context.coordinator
        
        // ARReferenceImage를 이용하여 이미지 트래킹을 하는 방법도 고려
        // environmentTexturing를 이용해서 텍스처링하는 방법도 고려
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        arView.session.run(configuration)
        
        
        let anchor = AnchorEntity(plane: .any)
        // 일회성인건가...?
        // 표면에 대해 수평 수직 3D 설정

        
        // 기본 생성 AR text entity
         let text = ModelEntity(mesh: MeshResource.generateText("Hello AR", extrusionDepth: 0.01, font: .systemFont(ofSize: 0.03), containerFrame: .zero, alignment: .center, lineBreakMode: .byCharWrapping), materials: [SimpleMaterial(color: .blue, isMetallic: false)])
        
         anchor.addChild(text)
         text.generateCollisionShapes(recursive: true)
         arView.scene.anchors.append(anchor)
        
        return arView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    // MARK: - Update UIView(UIKit)
    // when SwiftUI interface state change
    func updateUIView(_ uiView: ARView, context: Context) {
        print("AR DEBUG: Update UIView")
    }
}


#Preview {
    ARSceneView()
}
