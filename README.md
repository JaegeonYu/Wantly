# 📱 WANTLY

> "내가 정말 원하는 것만 갖자" - 스마트한 소비 관리 앱

WANTLY는 단순한 쇼핑 리스트가 아닌, 소유하고 싶은 이유를 정리하고 구매 후 만족도를 기록하는 소비 일기입니다. 충동구매를 줄이고 가치 있는 소비 습관을 만들어갑니다.

## 🎯 핵심 가치

- **이유 기반 구매**: 왜 갖고 싶은지 명확히 하여 충동구매 방지
- **만족도 추적**: 구매 후 평가로 소비 패턴 개선
- **데이터 인사이트**: 시각화된 소비 분석으로 현명한 의사결정

## ✨ 주요 기능

### 1. 위시리스트 관리

- 물품명, 예상 가격, 사고 싶은 이유 기록
- 드래그앤드롭으로 우선순위 조정
- 갤러리/카메라로 이미지 추가
- 스와이프로 편집/삭제/구매완료

### 2. 구매 목록 관리

- 위시리스트에서 자동 전환
- 예상 가격 vs 실제 가격 비교
- 별점으로 만족도 평가
- 구매 후기 작성

### 3. 인사이트 분석

- 월별 지출 그래프
- 카테고리별 소비 비율
- 베스트/워스트 구매 리스트
- 기간별 필터링 (올해/6개월/3개월/전체)

## 🛠️ 기술 스택

```yaml
Framework: Flutter 3.x
Language: Dart
State Management: Provider
Database: Hive (Local NoSQL)
Architecture: Clean Architecture
```

### 주요 패키지

- `hive` - 로컬 데이터베이스
- `freezed` - 불변 데이터 모델
- `provider` - 상태 관리
- `fl_chart` - 데이터 시각화
- `image_picker` - 이미지 선택
- `flutter_slidable` - 스와이프 액션

## 📁 프로젝트 구조

```
lib/
├── core/           # 공통 요소 (테마, 상수, 유틸)
├── data/           # 데이터 계층 (모델, Repository)
├── domain/         # 도메인 계층 (인터페이스)
└── presentation/   # UI 계층 (화면, Provider)
```

## 🚀 시작하기

### 사전 요구사항

- Flutter SDK 3.0 이상
- Dart 3.0 이상

### 설치

```bash
# 저장소 클론
git clone https://github.com/yourusername/wantly.git
cd wantly

# 패키지 설치
flutter pub get

# 코드 생성 (Freezed, Hive)
flutter pub run build_runner build --delete-conflicting-outputs
```

### 실행

```bash
# 웹에서 실행
flutter run -d chrome

# Android에서 실행
flutter run -d android

# iOS에서 실행
flutter run -d ios
```

### 빌드

```bash
# Android APK
flutter build apk --release --no-tree-shake-icons

# Android AAB (Play Store)
flutter build appbundle --release --no-tree-shake-icons

# iOS
flutter build ios --release
```

> **Note**: `--no-tree-shake-icons` 플래그는 동적 아이콘 생성 때문에 필요합니다.

## 📊 개발 진행 상황

- [x] Phase 1: 기초 설정
- [x] Phase 2: 데이터 모델 & Repository
- [x] Phase 3: 위시리스트 CRUD
- [x] Phase 4: 구매 목록 관리
- [x] Phase 5: 인사이트 분석
- [ ] Phase 6: 상세 화면
- [ ] Phase 7: 검색 & 필터
- [ ] Phase 8: 이미지 관리 개선
- [ ] Phase 9: 태그 & 카테고리 관리
- [ ] Phase 10: 설정 화면

**진행률**: 50% (5/10 Phase 완료)

## 🎨 스크린샷

_(추후 추가 예정)_

## 🤝 기여하기

이 프로젝트는 개인 학습 프로젝트입니다. 이슈나 개선 제안은 언제나 환영합니다!

---

**WANTLY** - 더 나은 소비 습관을 만들어가는 여정 🎯
