//
//  Helpers.swift
//  ButtonARGuide
//
//  Created by user on 11/25/23.
//

import Foundation

// The labels for the 23 classes.
let labels = [
  "음성인식", "모드선택", "음량조절", "탐색", "통화", "통화종료", "모드", "크루즈실",
  "메뉴선택", "크루즈설정", "확인", "크루즈해제", "전자동 조절 버튼", "작동 정지", "앞유리 서리제거 버튼",
  "뒷유리 서리제거 버튼", "바람 방향 선택 버튼", "에어컨 선택 버튼", "내/외기 공기 선택 버튼", "전동 파워 스티어링 경고등", "저압타이어 경고등", "AEB 경고등", "ESC 작동 표시등"
]
var date1 : String = ""
var prelabels : [String] = [String]()
var predates : [String] = [String]()
var predetails : [String] = [String]()
var premessages = [Message]()
var prelabeldetails : [String : String] = ["음성인식" : "음성인식 버튼입니다.", "모드선택" : "해당 버튼을 눌러 라디오, AUX(사양 적용시), USB(iPad)(사양 적용시), DMB(사양 적용시), CD(사양 적용시) 등을 선택할 수 있습니다.\n\n오디오가 꺼져 있을 때 해당 버튼을 0.8초 이하로 짧게 누르면 오디오가 켜지고, 0.8초 이상 길게 누르면 꺼집니다.", "음량조절" : "해당 버튼을 올리거나 내리면 음량이 증가/감소합니다.", "탐색" : "해당 버튼을 0.8초 이하로 짧게 누르면 라디오 수신 시에는 미리 오디오 프리셋 버튼에 설정된 라디오 주파수를 선택할 수 있고, CD에서 음악을 듣고 있을 때에는 다음 또는 이전 곡의 처음을 들려줍니다.\n\n해당 버튼을 0.8초 이상 길게 누르면 라디오 수신시에는 지금 듣고 있는 방송에서 주파수가 증가 또는 감소하여 다음 또는 이전 방송이 있는 곳에서 정지하여 수신하고, CD에서 음악을 듣고 있을 때에는 버튼을 누르고 있는 동안 빨리감기/되감기가 작동됩니다.", "통화" : "통화 버튼입니다.", "통화종료" : "통화종료 버튼입니다.", "모드" : "모드버튼을 눌러 메인 메뉴를 설정할 수 있습니다.\n상, 하로 조정하여 하위 메뉴를 선택하고, [OK]버튼을 눌러 상세 메뉴를 들어가거나 설정을 완료할 수 있습니다.\n계기판 화면에서 [뒤로]를 선택하여 상위메뉴로 돌아갈 수 있습니다.", "크루즈실" : "CRUISE 버튼을 누르면 계기판에 크루즈 표시등이 켜집니다. 원하는 속도까지 가속하십시오.\n단, 차량 속도는 30km/h이상, 180km/h이하에서만 설정이 가능합니다.", "메뉴선택" : "메뉴를 설정할 수 있습니다.", "크루즈설정" : "크루즈 버튼을 누르고 원하는 속도에 도달하면 SET- 스위치를 짧게 당겨 내리십시오.\n계기판에 크루즈 설정 표시등이 켜지면서 설정 속도로 주행합니다.\n이때, 가속 페달을 밟지 않아도 설정한 속도를 유지합니다.", "확인" : "확인 버튼입니다.", "크루즈해제" : "크루즈해제 버튼입니다.", "전자동 조절 버튼" : "전자동 조절 방법\n엔진에 시동을 건 상태에서 다음과 같이 하십시오.\n\n1. 전자동 조절 버튼(AUTO)을 누르면 작동 표시창 내 표시등이 켜지고 설정된 온도에 따라 자동 제어됩니다.\n2. 설정 온도를 바꾸고자 할 때는 온도 조절 노브로 하십시오.\n3. 차 안을 쾌적한 온도로 유지하기 위해서는 계절에 관계없이 [AUTO]의 사용을 권장합니다. 또한 통상 온도는 23도쯤으로 설정하시기를 권장합니다.", "작동 정지" : "작동 정지 버튼을 누르면 바람 방향 선택과 내/외 공기 선택 기능(단, 외기 유입 상태로 전환됨)은 조절 가능하나 그외의 작동은 중지되며 해당 표시등이 꺼집니다.", "앞유리 서리제거 버튼" : "앞유리 서리제거 버튼을 누르면 버튼 내 표시등이 켜지고 표시창에 앞유리 서리 제거 표시가 나타납니다.\n\n유리창 습기 방지 기능이 설정된 경우 외기 유입이 자동으로 선택되며 바깥온도에 따라 에어컨도 자동으로 작동합니다.\n풍량 조절 스위치를 눌러 원하는 풍량을 설정하십시오.\n\n 앞유리 서리 제거 버튼을 한 번 더 누르면 버튼 내 표시등이 꺼지고, 각 버튼이 앞유리 서리 제거를 선택하기 이전 설정 상태로 되돌아 갑니다.", "뒷유리 서리제거 버튼" : "뒷유리 서리제거 버튼입니다.", "바람 방향 선택 버튼" : "바람 방향 선택 버튼을 눌러 원하는 위치로 바람의 방향을 선택하십시오.", "에어컨 선택 버튼" : "에어컨 사용을 원하시면 에어컨 선택 버튼을 조절하십시오.", "내/외기 공기 선택 버튼" : "버튼내 표시등을 실내 순환을 원하시면 점등되도록, 외기 유입을 원하시면 소등되도록 내/외 공기 선택 버튼을 누르십시오.\n\n표시등이 점등되도록 하면 외부 공기는 차단되고, 실내공기만 순환하므로 외부 공기가 오염되어 있을 때와 최대 냉난방을 필요로 할 때 이 위치로 이동하십시오.\n\n표시등이 소등되도록 하면 외부 공기가 들어옵니다. 실내 환기시 사용하십시오.", "전동 파워 스티어링 경고등" : "시동을 [ON]으로 하거나 전동 파워 스티어링 시스템이 고장일 경우 경고등이 켜집니다.\n\n전동 파워 스티어링 경고등은 차량에 문제가 없더라도 시동 [ON] 상태에서 약 3초간 점등되었다가 소등됩니다.", "저압타이어 경고등" : "시동 [ON] 상태에서 약 3초간 경고등이 점등됩니다.\n\n만약 경고등이 점등하지 않거나 일정 시간(약 1분) 점멸 후 점등하면 타이어 공기압 감지 시스템에 이상이 있는 것이므로 서비스센터에 의뢰하십시오.\n\n타이어 공기압이 현저하게 낮아질 경우 저압 타이어 경고등이 점등됩니다.", "AEB 경고등" : "사용자 설정 모드에서 긴급제동 보조 시스템 기능이 꺼져있거나 시스템에 이상이 있을 경우 경고등이 켜집니다.\n\n사용자 설정 모드에서 기능 사용으로 설정이 되었음에도 경고등이 켜진다면 서비스센터에 정비를 의뢰하십시오.", "ESC 작동 표시등" : "시동 [ON] 상태에서 표시등이 점등되고, ESC장치에 이상이 없으면 약 3초 후 꺼집니다.\n\n운행중 차체 자세 제어장치(ESC)가 작동할 때는 작동하는 동안 점멸됩니다.\n\n단, ESC 작동 표시등이 소등되지 않고 계속 점등되거나 주행 중 점등될 경우 ESC 장치에 이상이 생긴 것이므로 서비스센터에서 점검을 받으십시오."]
