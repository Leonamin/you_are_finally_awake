# Dart Define
매일 내 API를 공개 설정하면서 마구마구 뿌렸었는데 이젠 그러고 싶지 않아서 안뿌리는 방법을 찾게 되었다.  

API 키를 숨기는 법은 여러가지가 있었지만 그냥 맘편히 Dart가 제공해주는 대로 쓰려고 --dart-define 이란 옵션을 사용하게 되었다.  

사용법은 명령행에서`--dart-define API_KEY=ASKDJASLKDJLKA` 를 추가하면 되고 따옴표 없이 추가한다.  

매번 이러면 귀찮기도 하고 명령행으로 앱을 빌드하고 실행시키지는 않으니까 vscode에 launch.json을 추가한다. 

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
                "GOOGLE_MAPS_PLATFORM_API_KEY=asdasdasdad"
            ]
        },
        {
            "name": "you_are_finally_awake (profile mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile",
            "args" : [
                "--dart-define",
                "GOOGLE_MAPS_PLATFORM_API_KEY=asdasdadasdasd"
            ]
        },
        {
            "name": "you_are_finally_awake (release mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release",
            "args" : [
                "--dart-define",
                "GOOGLE_MAPS_PLATFORM_API_KEY=asdadsasdadad"
            ]
        }
    ]
}
```

그러면 해당 API_KEY 접근은 어떻게 하느냐?  

1. Dart(Flutter포함)
`String.fromEnvironment('API_KEY');` 이거 하나면 끝이다 그리고 상수라서 앞에 const도 붙이면 금상첨화다.  

2. Android
안드로이드는 project.property('dart-defines')라는 형태로 app/build.gradle에서 참조가 가능하다.  

KEY VALUE 형식으로 들어오고 모두 base64 처리되어있다. (추후 문제가 생긴다면 반드시 base64라는 점을 참고하자)  

build.gradle에서 아래와 같이 자동화를 하면 된다.
```kotlin
def dartEnvironmentVariables = []
if (project.hasProperty('dart-defines')) {
    dartEnvironmentVariables = project.property('dart-defines')
        .split(',')
        .collectEntries { entry ->
            def pair = new String(entry.decodeBase64(), 'UTF-8').split('=')
            // 이렇게 자동화 하는 사람도 있다.
            // if (pair.first() == 'APP_CONFIG_ENV') {
            //     switch (pair.last()) {
            //         case 'staging':
            //             return [
            //                     APP_CONFIG_SUFFIX: ".staging",
            //                     APP_CONFIG_NAME  : "[STA] LinkFive"
            //             ]
            //         case 'production':
            //             return [
            //                     APP_CONFIG_SUFFIX: "",
            //                     APP_CONFIG_NAME  : "LinkFive"
            //             ]
            //     }
            // }
            [(pair.first()): pair.last()]
        }
}

...

android {
    ...
    defaultConfig {
        // +=로 추가하는게 아닌 아닌 =로 대입을 할경우 AndroidManifest에서 자동생성되는 applicationName이 없다고 나오게 된다.
        manifestPlaceholders += [
            API_KEY: dartEnvironmentVariables.API_KEY
        ]
    }

    // resource 파일에 사용할 경우 (string.xml이나 getString(R.string.api_key) 등) resValue 라인을 추가한다.
    resValue "string", "api_key", dartEnvironmentVariables.API_KEY
}
```

그러면 끝이다! 아래처럼 매니페스트나 리소스 파일, 안드로이드 코드 내에서 참조가 가능하다.  

매니페스트 파일 예시
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.you_are_finally_awake">

    ...

   <application
        android:label="you_are_finally_awake"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">

        <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="${GOOGLE_MAPS_PLATFORM_API_KEY}"/>
```
리소스 예시
```xml
<string name="com.very.secret.api" translatable="false">@string/api_key</string>
```
안드로이드 코드 예시
```kotlin
var apiKey = getString(R.string.api_key)
VerySecretApi.start(apiKey)
```

3. iOS
얘는 직접 안해봐서 적지 않는다.  

## 여담
https://stackoverflow.com/questions/69346395/are-compile-time-variables-secure-in-flutter/69349448#69349448  

dart-define은 무적이 아니다. strings lib/x86_64/libapp.so | grep API_KEY 해버리면 바로 API_KEY를 확인할 수 있다.  

구글 API 제한 설정을 충실히 따르고 그외 API들은 그냥 탈취당하자

## 참고
https://medium.com/flutter-community/how-to-setup-dart-define-for-keys-and-secrets-on-android-and-ios-in-flutter-apps-4f28a10c4b6c   

https://thiele.dev/blog/flutter-dart-define-part-2-dev-and-prod-package-names-and-bundle-ids/  
