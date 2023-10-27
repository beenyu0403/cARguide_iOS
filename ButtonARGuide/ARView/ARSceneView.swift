//
//  ARSceneView.swift
//  ButtonARGuide
//
//  Created by user on 10/14/23.
//  Edited by 송영훈 from 10/25/23.
//

import SwiftUI
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
        // Screen size : 1179*2556(iPhone 15 pro)
        let arView = ARView(frame: .zero)
        
        // Connect ARView with UIKit
        // Help control event & networking
        context.coordinator.view = arView
        arView.session.delegate = context.coordinator
        
        let anchor = AnchorEntity(plane: .any)
        // 일회성인건가...?
        // 표면에 대해 수평 수직 3D 설정
//
//        let text = ModelEntity(mesh: MeshResource.generateText("Hello AR", extrusionDepth: 0.03, font: .systemFont(ofSize: 0.2), containerFrame: .zero, alignment: .center, lineBreakMode: .byCharWrapping), materials: [SimpleMaterial(color: .blue, isMetallic: true)])
//
//        anchor.addChild(text)
//        text.generateCollisionShapes(recursive: true)
//        arView.scene.anchors.append(anchor)
        
        return arView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    // MARK: - Update UIView(UIKit)
    // when SwiftUI interface state change
    func updateUIView(_ uiView: ARView, context: Context) {}
}


#Preview {
    ARSceneView()
}
