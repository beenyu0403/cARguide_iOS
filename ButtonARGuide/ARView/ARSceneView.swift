//
//  ARSceneView.swift
//  ButtonARGuide
//
//  Created by user on 10/14/23.
//  Edited by 송영훈 from 10/25/23.
//

import SwiftUI
import ARKit
import Vision

struct ARViewContainer: UIViewRepresentable {
    var objectDetectionService = ObjectDetectionService()
    let throttler = Throttler(minimumDelay: 1, queue: .global(qos: .userInteractive))
    var isLoopShouldContinue = true
    var lastLocation: SCNVector3?   // 마지막 카메라 위치 저장
    
    var arView = ARSCNView()
    @Binding var sessionInfo: String
    var sessionInfoLabel = UILabel()

    
    func makeUIView(context: Context) -> ARSCNView {
        print("DUBUG: Make UIView")
        
        arView.session.delegate = context.coordinator
        arView.delegate = context.coordinator
        // -> delegate 설정할때 뭔가 문제가 생김
        // 이거 없애니까 View위에 Text 뜨는것도 없어짐
        arView.scene = SCNScene()

        // 기타 ARSCNView 설정
        arView.autoenablesDefaultLighting = true
        
        startSession()
        
        return arView
    }
    
    func updateUIView(_ view: ARSCNView, context: Context) {
        print("DEBUG: Update UIView")
        
        startSession()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func startSession(resetTracking: Bool = false) {
        print("DEBUG: Start AR session")
        guard ARWorldTrackingConfiguration.isSupported else {
            assertionFailure("ARKit is not supported")
            return
        }
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        
        if resetTracking {
            arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        } else {
            arView.session.run(configuration)
        }
    }
    
    func stopSession() {
        print("DEBUG: Stop AR session")
        arView.session.pause()
    }
    
    func loopObjectDetection() {
        throttler.throttle { /*[weak self] in*/
//            guard let self = self else { return }
            
            if self.isLoopShouldContinue {
                self.performDetection()
            }
            self.loopObjectDetection()
        }
    }
    
    func performDetection() {
        print("DEBUG: Perform detection")
        guard let pixelBuffer = arView.session.currentFrame?.capturedImage else { 
            print("DEBUG: Get current frame error")
            return
        }
        objectDetectionService.detect(pixelBuffer: pixelBuffer)
        
//        objectDetectionService.detect(on: .init(pixelBuffer: pixelBuffer)) { /*[weak self]*/ result in
////            guard let self = self else { return }
//            switch result {
//            case .success(let response):
//                let rectOfInterest = VNImageRectForNormalizedRect(
//                    response.boundingBox,
//                    Int(self.arView.bounds.width),
//                    Int(self.arView.bounds.height))
//                
//                self.addAnnotation(rectOfInterest: rectOfInterest,
//                                   text: response.classification)
//            
//            case .failure(let error):
//                break
//            }
//        }
    }
    
    func addAnnotation(rectOfInterest rect: CGRect, text: String) {
        print("DEBUG: Add annotation")
        let point = CGPoint(x: rect.midX, y: rect.midY)
        
        let scnHitTestResults = arView.hitTest(point,
                                                  options: [SCNHitTestOption.searchMode: SCNHitTestSearchMode.all.rawValue])
        guard !scnHitTestResults.contains(where: { $0.node.name == BubbleNode.name }) else { return }
        
        guard let raycastQuery = arView.raycastQuery(from: point,
                                                        allowing: .existingPlaneInfinite,
                                                        alignment: .horizontal),
              let raycastResult = arView.session.raycast(raycastQuery).first else { return }
        let position = SCNVector3(raycastResult.worldTransform.columns.3.x,
                                  raycastResult.worldTransform.columns.3.y,
                                  raycastResult.worldTransform.columns.3.z)

        guard let cameraPosition = arView.pointOfView?.position else { return }
        
        let distance = (position - cameraPosition).length()
        guard distance <= 0.5 else { return }
        
        let bubbleNode = BubbleNode(text: text)
        bubbleNode.worldPosition = position
        
        arView.prepare([bubbleNode]) { /*[weak self]*/ success in
            if success {
                self.arView.scene.rootNode.addChildNode(bubbleNode)
            }
        }
    }
    
    mutating func onSessionUpdate(for frame: ARFrame, trackingState: ARCamera.TrackingState) {
        print("DEBUG: On session update")
        
        self.isLoopShouldContinue = false
        
        // Update the UI to provide feedback on the state of the AR experience.
        let message: String
        
        switch trackingState {
        case .normal where frame.anchors.isEmpty:
            // No planes detected; provide instructions for this app's AR interactions.
            message = "표면을 감지하기 위해 기기를 상하좌우로 움직여주세요."
            
        case .notAvailable:
            message = "탐지가 불가능합니다."
            
        case .limited(.excessiveMotion):
            message = "탐지 한계 - 기기를 천천히 움직여주세요."
            
        case .limited(.insufficientFeatures):
            message = "탐지 한계 - 기기가 표면이 정확한 곳을 향하게 하거나 불빛이 더 밝게 되도록 해주세요."
            
        case .limited(.initializing):
            message = "AR 화면을 구성합니다."
            
        default:
            // No feedback needed when tracking is normal and planes are visible.
            // (Nor when in unreachable limited-tracking states.)
            message = ""
            isLoopShouldContinue = true
            loopObjectDetection()
        }
        
        print("DEBUG: 세션 알림 -> \(message)")
//        sessionInfo = message
//        if message.isEmpty {
//            sessionInfo.removeAll()
//        }
        
//        sessionInfoLabel.isHidden = message.isEmpty
    }
}

struct ARSceneView : View {
    @State private var sessionInfo = ""
    
    var body: some View {
        ZStack{
            ARViewContainer(sessionInfo: $sessionInfo)
                .ignoresSafeArea(edges: .all)
            Text(sessionInfo)
        }
 
    }
}

#Preview {
    ARSceneView()
}
