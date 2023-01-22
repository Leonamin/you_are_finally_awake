# You are finally awake
```
Hey you, you're finally awake
```
The Elder Scrolls V: Skyrim을 플레이한 유저라면 누구나 익숙하고 수도없이 들어본 명대사.

이 프로젝트는 랄로프가 헬겐에 도착 직전인 도바킨을 깨우는 것처럼 앱이 사용자를 깨워줄 것 입니다.   

1. 앱에 목적지를 설정한다.
2. 알람을 실행하는 것처럼 이동을 시작한다.
3. 도착했다! 랄로프가 열심히 흔들어 사용자를 깨운다.
4. 이동을 종료하고 사용자는 목적지에 도착했다!

## 빌드 준비
### hive settings
run `flutter packages pub run build_runner build`, if you deleted TypeAdapter(like aaa.g.dart) files.
### dart_define settings
#### vscode
1. Create .vscode/launch.json
2. Add configuration as below:
```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "you_are_finally_awake",
            "request": "launch",
            "type": "dart",
            "args" : [
                "--dart-define",
                // "-Pdart-defines",
                "GOOGLE_MAPS_PLATFORM_API_KEY=YOUR_KEY"
            ]
        },
        {
            "name": "you_are_finally_awake (profile mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile",
            "args" : [
                "--dart-define",
                "GOOGLE_MAPS_PLATFORM_API_KEY=YOUR_KEY"
            ]
        },
        {
            "name": "you_are_finally_awake (release mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "args" : [
                "--dart-define",
                "GOOGLE_MAPS_PLATFORM_API_KEY=YOUR_KEY"
            ]
        }
    ]
}
```

## 이 프로젝트를 하면서 어떤 기술을 사용했을까
- Provider: 상태관리로 사용
- [Localizations](./log/localization.md): 다국어 관리 나중에 전세계 사용자가 사용하길 희망하며...
- Location: 무엇을 쓸지는 나중에 생각하자.
    - ?
- Alarm: 일단 생각중인거 Local Notifications
- Hive: 목적지 저장

## [기록물](./log/README.md)
기러기보단 기록이 제일 중요해!