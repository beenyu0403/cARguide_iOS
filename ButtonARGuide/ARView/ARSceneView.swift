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

struct ARViewContainer: UIViewRepresentable {
    // To Do: 모델 추가
    let arView = ARView(frame: .zero)   // Screen size : 1179*2556(iPhone 15 pro)
    
    // MARK: - Create UIView(UIKit) & initialize
    func makeUIView(context: Context) -> ARView {
        print("AR DUBUG: Make UIView")
        
        // To Do: environmentTexturing를 이용해서 텍스처링하는 방법도 고려
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        // Add tag mesh when (tap) recognized
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.isViewTapped)))
        arView.session.run(configuration)   // 상세 페이지로 넘어가면 Pause를 이용하여 멈추자
        print("AR DEBUG: ARView appear")
        
        return arView
    }
    
    // MARK: - Update UIView(UIKit)
    // When SwiftUI interface state change
    func updateUIView(_ uiView: ARView, context: Context) {
        print("AR DEBUG: Update UIView")
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - Content View
struct ARSceneView : View {
    @State private var detectedObjectLabel: String = "Finding object"
    
    var body: some View {
        ARViewContainer().ignoresSafeArea(edges: .all)
    }
}

#Preview {
    ARSceneView()
}
