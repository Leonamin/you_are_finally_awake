# Localization 
## 다국어 지원 설정 파일
- l10n - localization 지역화 i가 아니라 l이다
- i18n - internationalization 국제화
- g11n - globalization 글로벌화
- m17n - multilingalization 다언어화 

그러니까 project_folder/l10n.yaml 파일을 만들자 i 가 아니라 l이다 이거 헷갈려서 안되네

## .arb
얘도 json 처럼 필드 마지막은 ,가 안붙는다 , 떼자

## AppLocalizaions가 안나와요!
.dart_tool에서 flutter_gen이 생성되도 AppLocalizations이 안나오기도 한다. 그럴 때에는 vscode를 재시작하자.  

근데 AppLocalizations가 존재하지만 안될 수도 있다.

이럴 때에는 MaterialApp()에서 localizationsDelegates랑 supportedLocales를 명시적으로 해서 그럴 수도 있다.

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    title: 'My app',
    home: ... ,
);
```
위와 같이 자동 생성된 delegates를 넣으면 된다.


## 추가! 앱의 제목을 어떻게 설정할까요?
title에 그냥 때려박으면 로케일 설정 자체가 아직 안되서 정적 생성에 동적 변수를 때려 박는 꼴이라서 안된다.

그럴 떄에는 MaterialAPP에 `onGenerateTitle: (context) => AppLocalizations.of(context).applicationTitle,` 을 넣어주자