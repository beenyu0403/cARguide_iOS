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
    var lastLocation: SCNVector3?
    var sessionInfo: String = ""
    
    var arView = ARSCNView()
    @State var isLoopShouldContinue = true
    
    func makeUIView(context: Context) -> ARSCNView {
        arView.session.delegate = context.coordinator
        arView.delegate = context.coordinator
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
        guard ARWorldTrackingConfiguration.isSupported else { return }

        arView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
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
        isLoopShouldContinue = false
        throttler.workItem.cancel()
        objectDetectionService.checkAlreadyPredictLabel.removeAll()
    }
    
    func resetSession() {
        print("DEBUG: Resset AR session")
        
        isLoopShouldContinue = false
        throttler.workItem.cancel()
        objectDetectionService.checkAlreadyPredictLabel = [Bool](repeating: false, count: 23)

        startSession(resetTracking: true)
    }
    
    func loopObjectDetection() {
        throttler.throttle {
            if self.isLoopShouldContinue {
                self.performDetection()
            }
            self.loopObjectDetection()
        }
    }
    
    func performDetection() {
        print("DEBUG: --------------------------------------------")
        print("DEBUG: Perform detection")
        guard let pixelBuffer = arView.session.currentFrame?.capturedImage else { return }
        
        objectDetectionService.detect(on: .init(pixelBuffer: pixelBuffer)) { result in
            switch result {
            case .success(let response):
                // 한번에 얻어낸 결과들 전부 Add annotation을 통해 Label mesh 추가
                for res in response {
                    // 얻어낸 Bounding box를 Normal box로 변경
                    let rectOfInterest = VNImageRectForNormalizedRect(
                        res.boundingBox,
                        Int(arView.bounds.width),
                        Int(arView.bounds.height))
                    
                    self.addAnnotation(rectOfInterest: rectOfInterest,
                                       text: res.classification)
                    
                }
            
            case .failure(let error):
                break
            }
        }
    }
    
    func addAnnotation(rectOfInterest rect: CGRect, text: String) {
        print("DEBUG: Add annotaion function called")
            
        
        let point = CGPoint(x: rect.minX, y: rect.minY)
        
        guard let raycastQuery = arView.raycastQuery(from: point,
                                                     allowing: .estimatedPlane,
                                                     alignment: .any),
              let raycastResult = arView.session.raycast(raycastQuery).first
                else {
                    print("DEBUG: Raycast result error")
                    return
                }
        let position = SCNVector3(raycastResult.worldTransform.columns.3.x,
                                  raycastResult.worldTransform.columns.3.y,
                                  raycastResult.worldTransform.columns.3.z)

        guard let cameraPosition = arView.pointOfView?.position else {
            return
        }
        
        let bubbleNode = BubbleNode(text: text)
        bubbleNode.worldPosition = position
        
        arView.prepare([bubbleNode]) { success in
            if success {
                print("DEBUG: Add annotation")
                self.arView.scene.rootNode.addChildNode(bubbleNode)
            }
        }
    }
    
    mutating func onSessionUpdate(for frame: ARFrame, trackingState: ARCamera.TrackingState) {
        self.isLoopShouldContinue = false
        
        let message: String
        
        switch trackingState {
        case .normal where frame.anchors.isEmpty:
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
            message = ""
            isLoopShouldContinue = true
            loopObjectDetection()
        }
        
        sessionInfo = message
        
        if message != "" {
            print("DEBUG: 세션 알림 -> \(sessionInfo)")
        }
    }
}

struct ARSceneView : View {
    var body: some View {
        let arViewContainer = ARViewContainer()
        ZStack {
            arViewContainer.ignoresSafeArea(.all)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Reset") {
                            arViewContainer.resetSession()
                        }
                    }
                }
            
        }.onDisappear() {
            arViewContainer.stopSession()
        }
    }
}

