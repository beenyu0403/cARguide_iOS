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
    var mlModel = try! VNCoreMLModel(for: ButtonDetector().model)
    var checkAlreadyPredictLabel = [Bool](repeating: false, count: 23)
    
    lazy var coreMLRequest: VNCoreMLRequest = {
        let request = VNCoreMLRequest(model: mlModel,
                                      completionHandler: self.coreMlRequestHandler)
        request.imageCropAndScaleOption = .centerCrop
        return request
    }()
    
    
    private var completion: ((Result<[Response], Error>) -> Void)?
    
    func detect(on request: Request, completion: @escaping (Result<[Response], Error>) -> Void) {
        self.completion = completion
        
        let orientation = CGImagePropertyOrientation(rawValue:  UIDevice.current.exifOrientation) ?? .up
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: request.pixelBuffer,
                                                        orientation: orientation)

        do {
            try imageRequestHandler.perform([coreMLRequest])
        } catch {
            self.complete(.failure(error))
            return
        }
    }
}

private extension ObjectDetectionService {
    func coreMlRequestHandler(_ request: VNRequest?, error: Error?) {
        if let error = error {
            complete(.failure(error))
            return
        }
        
        guard let request = request, let results = request.results as? [VNCoreMLFeatureValueObservation] else {
            fatalError("DEBUG: Get result error")
        }
        
        // 결과값이 담긴 Array
        if let multiArray = results.first!.featureValue.multiArrayValue {
            var response = [Response]()
            
            // 배치사이즈를 순회하며 confidence가 임계치 이상인 것을 찾음
            for i in 0..<25200
            where multiArray[[0, i, 4] as [NSNumber]].floatValue > 0.9 {
                let x = (multiArray[[0, i, 0] as [NSNumber]].doubleValue/640)
                let y = (multiArray[[0, i, 1] as [NSNumber]].doubleValue/640)
                let width = (multiArray[[0, i, 2] as [NSNumber]].doubleValue/640)
                let height = (multiArray[[0, i, 3] as [NSNumber]].doubleValue/640)
                
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
                
                // 첫 탐지된 Class를 저장 및 View에 추가
                if !checkAlreadyPredictLabel[classLabelIndex-5] {
                    checkAlreadyPredictLabel[classLabelIndex-5] = true

                    let bb: CGRect = CGRect(x: x, y: y,
                                            width: width, height: height)
                    let featureName = self.getFeatureName(for: classLabelIndex - 4)
                    
                    response.append(Response(boundingBox: bb,
                                             classification: featureName))
                }
            }
            complete(.success(response))
        }
    }
    
    func complete(_ result: Result<[Response], Error>) {
        DispatchQueue.main.async {
            self.completion?(result)
            self.completion = nil
        }
    }
    
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


