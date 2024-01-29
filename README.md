# 🤖 AI 챗봇 앱

## 팀원
|범|도라|
|:--:|:--:|
|<img src="https://avatars.githubusercontent.com/u/118453865?v=4" width=200>|<img src="https://avatars.githubusercontent.com/u/68066104?v=4" width=200>|

<br/>

## 프로젝트 개요

OpenAI API를 사용해서 챗봇에게 질문을 하고 그에 대한 응답을 채팅 형식으로 확인할 수 있다.

<br/>

## 구현 영상

|기본 대화|스크롤|키보드 레이아웃|
|:--:|:--:|:--:|
|<img src="https://github.com/snowy-summer/ios-chat-bot/assets/118453865/45c0fbc9-aa83-4f38-81ec-3c5788845f40" width=300>|<img src="https://github.com/snowy-summer/ios-chat-bot/assets/118453865/bfd3d93b-cd43-4186-8f30-35c049ffc62d" width=300>|<img src="https://github.com/snowy-summer/ios-chat-bot/assets/118453865/b0275d02-af28-4393-a327-c01c75b38bdf" width=300>|
<br/>

## 프로젝트 파일 구조

```swift
.
├── ChatBot
│   ├── ChatBot
│   │   ├── Application
│   │   │   ├── AppDelegate.swift
│   │   │   └── SceneDelegate.swift
│   │   ├── ChattingViewController.swift
│   │   ├── UpdateUIDelegate.swift
│   │   ├── DTO
│   │   │   ├── CommonModel.swift
│   │   │   ├── RequestModel.swift
│   │   │   └── ResponseModel.swift
│   │   ├── Enum
│   │   │   ├── ContentType.swift
│   │   │   ├── DiffableDataSourceSection.swift
│   │   │   ├── Direction.swift
│   │   │   ├── HttpMethod.swift
│   │   │   └── Path.swift
│   │   ├── Error
│   │   │   ├── JSONConvertError.swift
│   │   │   └── NetworkError.swift
│   │   ├── Extension
│   │   │   ├── Bundle+Extension.swift
│   │   │   └── UITextView+Extension.swift
│   │   ├── Info.plist
│   │   ├── Network
│   │   │   ├── NetworkManager.swift
│   │   │   └── NetworkManagerProtocol.swift
│   │   ├── Resource
│   │   │   ├── APIKeys.plist
│   │   │   ├── Assets.xcassets
│   │   │   │   ├── AccentColor.colorset
│   │   │   │   │   └── Contents.json
│   │   │   │   ├── AppIcon.appiconset
│   │   │   │   │   └── Contents.json
│   │   │   │   └── Contents.json
│   │   │   └── Base.lproj
│   │   │       └── LaunchScreen.storyboard
│   │   ├── Service
│   │   │   ├── ChatRepository.swift
│   │   │   ├── OpenAIRepository.swift
│   │   │   └── ServiceProvider.swift
│   │   ├── URL
│   │   │   ├── APIBaseURLProtocol.swift
│   │   │   └── OpenAIURL.swift
│   │   ├── Utility
│   │   │   └── JSONConverter.swift
│   │   └── View
│   │       ├── ChatTextInputViewButtonDelegate.swift
│   │       ├── CustomCell
│   │       │   ├── LeftBalloonCell.swift
│   │       │   └── RightBalloonCell.swift
│   │       └── CustomView
│   │           ├── ChatBalloon.swift
│   │           ├── ChatCollectionView.swift
│   │           ├── ChatRoomView.swift
│   │           ├── ChatTextInputView.swift
│   │           └── LoadingView.swift
│   └── ChatBot.xcodeproj
└── README.md
```
<br/>

## 객체의 역할

### controller

| 이름 | 타입 | 내용 |
| --- | --- | --- |
| ChattingViewController | final class | View와 실행로직(Service)를 연결하는 객체 |
| UpdateUIDelegate | protocol | Service가 갖고 있는 데이터에 수정이 생기면 View에 알리는 Delegate protocol |

### View

- ChatRoomView > ChatCollectionView > CustomCell, Loading View > ChatBalloon
- ChatRoomView > ChatTextInputView

### DTO

- RequestModel
- ResponseModel
- CommonModel

### Network

| 이름 | 타입 | 내용 |
| --- | --- | --- |
| NetworkManager | final class | OpenAI API와 실제로 통신을 하는 class, encode와 decode를 처리 |
| NetworkManagerProtocol | protocol | NetworkManager가 채택 및 준수 |

### Service

| 이름 | 타입 | 내용 |
| --- | --- | --- |
| ServiceProvider | class | VC에게 입력값을 받아와 repository에 알맞은 데이터로 변환하여 전달하는 객체 |
| OpenAIRepository | protocol | 추후에 Open Ai의 다른 API를 사용하는 경우를 생각하여 추상화 한 프로토콜 |
| ChatRepository | class | Chat API를 사용하여 데이터를 전달받아 NetworkManager에게 네트워크 통신을 요청하는 객체 |

### Utility

| 이름 | 타입 | 내용 |
| --- | --- | --- |
| JSONConverter | struct | 데이터 파일의 encode와 decode를 담당 |

<br/>

## Trouble Shooting

- `DiffableDataSource`와 `NSDiffableDataSourceSnapshot`
    - `DiffableDataSource`는 데이터를 관리하고 collection View에 cell을 제공하는데 사용하는 객체이다.
    - `NSDiffableDataSourceSnapshot`는 고유한 `ID(= UUID)로 식별`하도록 설정하였고, ID를 제외한 contents에 변경이 있을 때 다음과 같은 두 방법으로 원본 데이터의 수정을 시도하였다.
        1. 원본의 id는 유지한 채로 값을 변경하기
            - `reconfigureItems` 를 통해서 동일한 id값의 데이터를 업데이트한다.
            - 이 경우에는 cell이 업데이트될 때 `prepareForeReuse` 를 호출하지 않고 기존의 cell을 사용한다.
        2. 원본의 데이터를 교체하기
            - 원본의 데이터를 교체하는 것이기 때문에 ID가 바뀌는 것이다.
            - 이 경우에는 cell이 화면 범위를 벗어나지 않았음(= cell이 재사용되는 범위가 아님)에도 불구하고 cell이 재사용되는 것을 확인할 수 있다.
    - 원래는 하나의 셀을 사용해서 왼쪽 말풍선과 오른쪽 말풍선을 구분지어서 사용했기 때문에 cell의 재사용과 관련된 이슈를 처리하고자 첫 번째 방법으로 사용하고 있는 cell의 재사용을 막고자 했으나
    - 현재는 왼쪽 말풍선과 오른쪽 말풍선을 각각 생성해서 사용하고 있기 때문에 재사용의 문제가 발생하지 않고, 또한 기존의 snapshot에 새로운 데이터를 추가하지 않고 새로운 snapshot을 통으로 만들기 때문에 고유한 ID값을 유지할 필요가 없어 2번째 방법으로 사용하고 있다.

- 구조와 역할의 분리
    - 기존의 구조는 ViewController가 UI의 변경 로직과 비즈니스 로직을 모두 가지고 있었다.
    - collectionView, TextInputView등을 하나의 View로 만들어 VC의 View를 대체하도록 변경하였다. / ViewController에 존재하던 비즈니스 로직을 ChatRepository로 위치 변경하였다.
        - View에 이벤트가 발생하면 ViewController의 지시를 통해 ChatRepository로 비즈니스 로직이 실행되고
        - ChatRepository에서 데이터의 수정이 일어나면 VC를 통해 View의 업데이트를 수행할 수 있다.
    - ViewController와 ChatRepository 사이에 ServiceProvider를 위치 시켜 다른 repository가 추가되어 Audio,Image등 을 서비스가 가능하도록 변경
