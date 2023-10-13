//
//  ARSceneView.swift
//  ButtonARGuide
//
//  Created by user on 10/14/23.
//

import SwiftUI
import RealityKit

struct ARSceneView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        
        context.coordinator.view = arView
        arView.session.delegate = context.coordinator
        
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        let text = ModelEntity(mesh: MeshResource.generateText("Hello AR", extrusionDepth: 0.03, font: .systemFont(ofSize: 0.2), containerFrame: .zero, alignment: .center, lineBreakMode: .byCharWrapping), materials: [SimpleMaterial(color: .blue, isMetallic: true)])
        
        anchor.addChild(text)
        text.generateCollisionShapes(recursive: true)
//        let box = ModelEntity(mesh: MeshResource.generateBox(size: 0.3), materials: [SimpleMaterial(color: .blue, isMetallic: true)])
//        anchor.addChild(box)
//        box.generateCollisionShapes(recursive: true)
        
        /*
        
        let sphere = ModelEntity(mesh: MeshResource.generateSphere(radius: 0.3), materials: [SimpleMaterial(color: .yellow, isMetallic: true)])
        sphere.position = simd_make_float3(0, 0.4, 0)
        
        anchor.addChild(sphere)
         */
        arView.scene.anchors.append(anchor)
        
        
        
        
        return arView
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}


#Preview {
    ARSceneView()
}
