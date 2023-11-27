import ARKit
import SwiftUI

class BubbleNode: SCNNode {
    static let name = String(describing: BubbleNode.self)
    
    let bubbleDepth: CGFloat = 0.03
    let hiddenGeometry = SCNSphere(radius: 0.1)
    
    init(text: String) {
        super.init()
        
        let billboardConstraint = SCNBillboardConstraint()  // Mesh 정렬
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        
        // BUBBLE-TEXT
        let bubble = SCNText(string: text, extrusionDepth: CGFloat(bubbleDepth))
        print("DEBUG: Node initialize and name is \(text)")
        
        let font = UIFont(name: "Futura", size: 0.2)
        bubble.font = font
        bubble.alignmentMode = CATextLayerAlignmentMode.center.rawValue
        bubble.firstMaterial?.specular.contents = UIColor.white
        bubble.firstMaterial?.isDoubleSided = true
        bubble.chamferRadius = CGFloat(bubbleDepth)
        
        
        
        // BUBBLE NODE
        let (minBound, maxBound) = bubble.boundingBox
        let bubbleNode = SCNNode(geometry: bubble)
        // Centre Node - to Centre-Bottom point
        bubbleNode.pivot = SCNMatrix4MakeTranslation((maxBound.x - minBound.x) / 2,
                                                     minBound.y,
                                                     Float(bubbleDepth) / 2)
        // Reduce default text size
        bubbleNode.scale = SCNVector3Make(0.2, 0.2, 0.2)
        
        // CENTRE POINT NODE
        let sphere = SCNSphere(radius: 0.005)
        sphere.firstMaterial?.diffuse.contents = UIColor.gray
        let sphereNode = SCNNode(geometry: sphere)
        
        let searchNode = SCNNode(geometry: hiddenGeometry)
        searchNode.name = Self.name
        searchNode.eulerAngles.x = -90
        searchNode.geometry?.materials.first?.transparency = 0
        
        // BUBBLE PARENT NODE
        addChildNode(bubbleNode)
        addChildNode(sphereNode)
        addChildNode(searchNode)
        bubbleNode.constraints = [billboardConstraint]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
