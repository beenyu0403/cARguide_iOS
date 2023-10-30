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
    
    // MARK: - Create UIView(UIKit) & initialize
    func makeUIView(context: Context) -> ARView {
        print("AR DUBUG: Make UIView")
        // To Do: Navigation bar에 사용법 버튼 생성 및 사용법 페이지 생성
        
        // Screen size : 1179*2556(iPhone 15 pro)
        let arView = ARView(frame: .zero)
        print("AR DEBUG: ARView appear")
        
        // To Do: ARReferenceImage를 이용하여 이미지 트래킹을 하는 방법도 고려
        // To Do: environmentTexturing를 이용해서 텍스처링하는 방법도 고려
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        arView.session.run(configuration)
        
        // Add tag mesh when (tap) recognized
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.isViewTapped)))
        
        return arView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // MARK: - Update UIView(UIKit)
    // When SwiftUI interface state change
    func updateUIView(_ uiView: ARView, context: Context) {
        print("AR DEBUG: Update UIView")
    }
}

// MARK: - Content View
struct ARSceneView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ARSceneView()
}
