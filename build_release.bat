@echo off
REM WANTLY 앱 릴리스 빌드 스크립트
REM IconData를 동적으로 생성하기 때문에 --no-tree-shake-icons 플래그 필요

echo ====================================
echo  WANTLY 앱 릴리스 빌드 시작
echo ====================================
echo.

flutter clean
flutter pub get
flutter build apk --release --no-tree-shake-icons

echo.
echo ====================================
echo  빌드 완료!
echo  APK 위치: build\app\outputs\flutter-apk\app-release.apk
echo ====================================
pause

