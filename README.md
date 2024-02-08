# 🏦은행창구 관리앱
고객을 10명씩 추가하면 은행직원이 은행업무를 관리해준다.


## 목차

1. [팀원](#1-팀원)
2. [클래스다이어그램](#2-클래스-다이어그램)
3. [타임라인](#3-타임라인)
4. [실행 화면(기능 설명)](#4-실행화면기능-설명)
5. [트러블 슈팅](#5-트러블-슈팅)
6. [참고 링크](#6-참고-링크)

<br>

## 1.팀원

| [mireu](https://github.com/mireu930)  | [희동](https://github.com/MyNB1) |
| :--------: | :--------: |
|<img src=https://github.com/mireu79/ios-rock-paper-scissors/assets/125941932/b4a69222-b338-4a7f-984c-be5bd78dc1d8 height="150"/> |<img src=https://github.com/mireu930/ios-bank-manager/assets/148876644/30519750-d508-42a1-8711-20ba68d661c7 height="150"/> | 

<br>

## 2. 클래스 다이어그램





<br>

## 3. 타임라인
|날짜|내용|
|------|---|
|24.1.22|프로젝트 흐름에 대한 파악 및 공식문서 공부|
|24.1.23|Queue,LinkedList, Node에 대한 개념 및 흐름에 대한 공부|
|24.1.24|Queue,LinkedList, Node 공부한 개념을 통해 코드로 적용,유닛테스트 진행 |
|24.1.25|dequeue할떄 데이터가없으면 에러처리 수정, Node에서 중간에 들어가도록 insert메서드 구현, 중간에 값이 삭제되도록 remove메서드 수정 |
|24.1.26|구현한 Queue를 바탕으로 콘솔창에 BankManager구현, 모든 업무가 끝나면 업무를 마감하고, 각 고객의 업무를 처리하는 데 걸리는 시간은 0.7초이고, 은행원이 한 번에 처리할 수 있는 고객은 한 명을 구현하여 콘솔창에 띄우도록 구현|
|24.1.29-31|파일폴더링, 접근제어, 메서드 분리, 의존성주입, get프로퍼티를 채택한 타입 read-only만 적용되도록 private(set)적용|
|24.2.1-2|은행업무 enum타입 추가, GCD활용(2개의 커스텀큐를 생성하여 semaphore로 task수를 제한하여 비동기처리), 메서드 분리 |
|24.2.6|스토리보드 없이 코드로 UI구성(오토레이아웃), 콘솔앱에서의 모델 UI로 이동, 고객추가버튼을 눌렀을떄 타이머가 작동하도록 구현, 초기화버튼을 누르면 타이머가 reset되도록 구현, 고객추가 버튼을 누르면 임의의 10명 고객이 추가되도록 구현 |
|24.2.7|두개의 Queue를 한Queue에서 처리되도록 수정, 델리게이트 패턴으로 대기중업무가 업무중이면 이동하도록 업무가 끝나면 화면에서 사라지도록 UI업데이트 구현|
|24.2.8|스크롤하면 타이머가 일시정지되는 에러 수정, Bool타입으로 업무가 끝나면 타이머가 일시정지 되도록 수정, loan업무를 한명이 할수 있도로고 semaphore수정, MVC파일분리 |

<br>

## 4. 실행화면(기능 설명)


| 임의의 10명의 고객이 추가 | 모든업무가 끝나면 타이머 멈춤 |
| :--------: | :--------: |
| <img src=https://github.com/tasty-code/ios-bank-manager/assets/148876644/82a18fbc-d75d-49be-ac29-074eb89fc699 height="400"/> | <img src=https://github.com/tasty-code/ios-bank-manager/assets/148876644/7ad4053c-36fd-438f-96e7-be790e889ed1 height="400"/> 
| 업무시간은 초기화하지 않고 누적 | 초기화 |
<img src=https://github.com/tasty-code/ios-bank-manager/assets/148876644/28665cdc-787d-46bb-bd05-1a33ffbfe2ba height="400"/>|  <img src=https://github.com/tasty-code/ios-bank-manager/assets/148876644/7328c043-64a6-48e0-bd42-e81a67fc71f1 height="400"/>
|


  

<br>

## 5. 트러블 슈팅
#### 1.업무가 끝나면 타이머가 일시정지되어야하는데 계속진행되는 이슈가 있었습니다.
고객을 10명추가하는 버튼을 누르고 업무중인 업무가 종료되면 타이머가 일시정지되어야하는데 멈추지 않고, 타이머가 계속흘러가는 이슈를 발견하여 dispatchGroup에 종료시점을 알리는 notify메서드를 넣어줬습니다. 그래서 종료를 알리는 시점에 timer가 멈출수 있도록 invalidate를 클로저내에서 실행되도록 구현해줬더니 업무가 끝나면 타이머가 일시정지되었습니다.
```swift
timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(runningTimer), userInfo: nil, repeats: true)

        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.timer?.invalidate()
        }
    }
```

#### 2.UI에서 스크롤하면 업무가 타이머가 일시정지되는 이슈가 있었습니다.
업무를 진행하는 중에 UI화면에서 스크롤을 하더라도 타이머가 계속 흘러가야하는데, 스크롤을 하면 타이머가 멈추는 이슈가 있었습니다. 그래서 timer가 nil이 아닌지 확인하고 guard문을 통과했을때 타이머를 메인 run loop( 메인 run loop은 많은 애플리케이션에서 사용자 인터페이스를 업데이트하는 역할을 담당)에 추가하여 타이머가 계속 작동하도록 수정해줬습니다.
```swift
guard let timer = timer else { return }
        RunLoop.main.add(timer, forMode: .common)
```
#### 3.고객추가를 2-3번 눌렀을때 업무가 끝나면 타이머가 일시정지 되지않는 이슈가 있었습니다.
고객추가를 한번누르면 업무가 끝났을때 타이머가 일시정지되는데, 2-3번 누르더라도 업무가 끝나면 타이머가 일시정지되어야하는데, 2-3번 누르면 업무가 다끝나도 타이머가 멈추지않고 계속 진행되는 이슈를 발견했습니다. 그래서 Bool타입으로 타이머 실행여부를 확인하고 그에 맞는 동작을 수행하도록 해줬습니다. false를 줘서 타이머가 아직 실행 중이지 않은 경우에 새로운 타이머를 생성하고 시작하고, true로 업데이트하여 타이머가 현재 실행 중임을 나타넀습니다.
 ```swift
guard isRunning == false else { return }
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(runningTimer), userInfo: nil, repeats: true)

        guard let timer = timer else { return }
        RunLoop.main.add(timer, forMode: .common)
        isRunning = true

        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.timer?.invalidate()
            self.isRunning = false
        }
    }
```
#### 4.델리게이트패턴
모델에서 구현한 비동기처리를 데이터전달을 통해 UI에서도 동작할수있도록 델리게이트패턴을 사용했습니다.
```swift
protocol ManageLabel: AnyObject {
    func turn(cusomer: Customer)
    func quit(cusomer: Customer)
}
//
extension ViewController: ManageLabel {

    func turn(cusomer: Customer) {
        //...
    }

    func quit(cusomer: Customer) {
        DispatchQueue.main.async {
           //...
        }
    }
}
struct BankManager {
    //...
    func recieve(customer: Customer) {
        delegate?.turn(cusomer: customer)
        //...
        delegate?.quit(cusomer: customer)
    }
}
```

<br>

## 6. 참고 링크
[📖 공식문서 UITableView](https://developer.apple.com/documentation/uikit/uitableview)<br>
[📖 공식문서 오토레이아웃 가이드](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853-CH7-SW1)<br>
[🎥 wwdc2016](https://developer.apple.com/videos/play/wwdc2016/720/)<br>
[📖 공식문서 concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/)<br>
[📖 공식문서 generics](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics/)<br>
[📖 공식문서 closures](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/)<br>
[📚 Medium GCD](https://sujinnaljin.medium.com/ios-%EC%B0%A8%EA%B7%BC%EC%B0%A8%EA%B7%BC-%EC%8B%9C%EC%9E%91%ED%95%98%EB%8A%94-gcd-grand-dispatch-queue-1-397db16d0305)<br>
[📖 공식문서 Timer](https://developer.apple.com/documentation/foundation/timer)<br>
[📖 공식문서 UIView](https://developer.apple.com/documentation/uikit/uiview)<br>
[📖 공식문서 CFAbsoluteTimeGetCurrent](https://developer.apple.com/documentation/corefoundation/1543542-cfabsolutetimegetcurrent)

<br>


