//
//  ObjectDetectionService.swift
//  ButtonARGuide
//
//  Created by 송영훈 on 11/21/23.
//

import SwiftUI
import CoreML
import Vision
import ARKit

class ObjectDetectionService {
    // CoreML의 CVPixelBuffer를 처리하고 해석하기 위한 메서드 생성, 이것은 모델의 이미지를 분류하기 위해 사용 됩니다.
    func detect(pixelBuffer: CVPixelBuffer) {
        print("DEBUG: Detect function called")
        guard let coreMLDetectModel = try? ButtonDetector(configuration: MLModelConfiguration()),
              let visionDetectModel = try? VNCoreMLModel(for: coreMLDetectModel.model) else {
            fatalError("DEBUG: Loading core ml model error")
        }
        
        // Vision을 이용해 이미치 처리를 요청
        let request = VNCoreMLRequest(model: visionDetectModel) { request, error in
            guard error == nil else {
                fatalError("DEBUG: Failed request")
            }
            // 식별자의 이름(label)을 확인하기 위해 VNClassificationObservation로 변환해준다.
            guard let classification = request.results as? [VNCoreMLFeatureValueObservation] else {
                fatalError("DEBUG: Faild convert VNObservation")
            }
            
            // 결과값이 담긴 Array
            if let multiArray = classification.first!.featureValue.multiArrayValue {
                // 배치사이즈를 순회하며 confidence가 임계치 이상인 것을 찾음
                for i in 0..<25200
                where multiArray[[0, i, 4] as [NSNumber]].floatValue > 0.9 {
                    let curConfidence = multiArray[[0, i, 4] as [NSNumber]].floatValue  // 현재 confidence 값
                    
                    let x = multiArray[[0, i, 0] as [NSNumber]].intValue
                    let y = multiArray[[0, i, 1] as [NSNumber]].intValue
                    let width = multiArray[[0, i, 2] as [NSNumber]].intValue
                    let height = multiArray[[0, i, 3] as [NSNumber]].intValue
                    
                    var classLabelIndex: Int = 0    // 예측될 클래스 넘버
                    var maxValue: Float = 0.0
                    
                    // 임계치 이상일때 어떤 Class인지 확인
                    for j in 5..<28 {
                        let curLabelValue = multiArray[[0, i, j] as [NSNumber]].floatValue
                        if maxValue < curLabelValue {
                            maxValue = curLabelValue
                            classLabelIndex = j // 최대값인 label의 index 얻기
                        }
                    }
                    
                    let featureName = self.getFeatureName(for: classLabelIndex - 4)
                    print("DEBUG: Confidence가 \(curConfidence)로 0.9 이상입니다.")
                    print("DEBUG: Box info는 \([x, y, width, height]) 입니다")
                    print("DEBUG: Class name은 \(featureName) 입니다.")
                    print("DEBUG: --------------------------------------------")
                    
                    
                }
            }
        }
        
        // 기기의 회전방향
        let orientation = CGImagePropertyOrientation(rawValue:  UIDevice.current.exifOrientation) ?? .up
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: orientation)
        
        do {
            try handler.perform([request])
        } catch {
            print("DEBUG: Perform error -> \(error)")
        }
    }
}
//
//extension ObjectDetectionService {
//    func coreMlRequestHandler(_ request: VNRequest?, error: Error?) {
//        if let error = error {
//            complete(.failure(error))
//            return
//        }
//        
//        // 모델의 Predict 결과를 저장한다 by VNRecognizedObjectObservation
//        guard let request = request, let results = request.results as? [VNRecognizedObjectObservation] else {
//            complete(.failure(RecognitionError.resultIsEmpty))
//            return
//        }
//        
//        
//        guard let result = results.first(where: { $0.confidence > 0.2 }),
//            let classification = result.labels.first else {
//                complete(.failure(RecognitionError.lowConfidence))
//                return
//        }
//        
//        let response = Response(boundingBox: result.boundingBox,
//                                classification: classification.identifier)
//        
//        complete(.success(response))
//    }
//    
//    func complete(_ result: Result<Response, Error>) {
//        DispatchQueue.main.async {
//            self.completion?(result)
//            self.completion = nil
//        }
//    }
//}

enum RecognitionError: Error {
    case unableToInitializeCoreMLModel
    case resultIsEmpty
    case lowConfidence
}

extension ObjectDetectionService {
    struct Request {
        let pixelBuffer: CVPixelBuffer
    }
    
    struct Response {
        let boundingBox: CGRect     // 탐지된 x, y, w, h
        let classification: String  // 탐지 결과 label
    }
    
    func getFeatureName(for input: Int) -> String {
        switch input {
        case 1:
            return "음성인식"
        case 2:
            return "모드선택"
        case 3:
            return "음량조절"
        case 4:
            return "탐색"
        case 5:
            return "통화"
        case 6:
            return "통화종료"
        case 7:
            return "모드"
        case 8:
            return "크루즈실"
        case 9:
            return "메뉴선택"
        case 10:
            return "크루즈설정"
        case 11:
            return "확인"
        case 12:
            return "크루즈해제"
        case 13:
            return "전자동 조절 버튼"
        case 14:
            return "작동 정지"
        case 15:
            return "앞유리 서리제거 버튼"
        case 16:
            return "뒷유리 서리제거 버튼"
        case 17:
            return "바람 방향 선택 버튼"
        case 18:
            return "에어컨 선택 버튼"
        case 19:
            return "내/외기 공기 선택 버튼"
        case 20:
            return "전동 파워 스티어링 경고등"
        case 21:
            return "저압타이어 경고등"
        case 22:
            return "AEB 경고등"
        case 23:
            return "ESC 작동 표시등"
        default:
            return "알 수 없는 기능"
        }
    }
}


