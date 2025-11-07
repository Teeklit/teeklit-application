---
name: "\U0001F680 Feature Development"
about: 새로운 기능(UI / API / NoSQL DB 등)을 개발하거나 개선하기 위한 이슈를 생성합니다.
title: ''
labels: ''
assignees: ''

---

## 🧭 기능 개요 (Overview)
어떤 기능을 개발하려는지 간단히 요약해주세요.

> ex) 사용자 즐겨찾기 기능 추가  
> ex) 대시보드 데이터 구조 리팩토링

---

## 🧱 기능 유형 (Feature Type)
해당 기능의 범주를 선택해주세요.

- [ ] 🎨 UI / UX 관련
- [ ] ⚙️ API 관련
- [ ] 🗄 NoSQL DB 관련
- [ ] ✨ 일반 기능 (기타 로직, 서비스 등)

---

## 🎯 목표 (Goal)
이 기능이 해결하려는 문제나 기대되는 효과를 명확히 작성해주세요.

> ex) 사용자별 즐겨찾기 데이터를 Firestore에 저장하여, 로그인 시 즉시 불러올 수 있도록 함

---

## 📋 상세 구현 내용 (Implementation Details)
필요한 세부 구현 사항을 구체적으로 작성해주세요.  
(화면, 로직, 데이터 흐름, API 연동 등 포함)

> ex)
> - 즐겨찾기 버튼 UI 추가
> - Firestore의 user/{uid}/bookmarks 구조 설계
> - 데이터 추가 및 삭제 기능 구현

---

## 🧠 선택 항목별 세부 내용

### 🎨 UI / UX 관련일 경우
- 화면명:  
- 주요 구성요소:  
  - [ ] 버튼  
  - [ ] 입력 필드  
  - [ ] 네비게이션  
- 참고 디자인(Figma 등):  
- 비고:  

---

### ⚙️ API 관련일 경우
- 엔드포인트(URL):  
  > ex) POST /api/user/bookmark
- 요청 예시(Request):
```json
  {
    "userId": "12345",
    "postId": "abcd"
  }
```
- 응답 예시(Response):
```json
  {
    "status": "success",
    "message": "Bookmark added"
  }
```
- 구현 상세:
  - [ ] Controller / Service 추가
  - [ ] Firestore 연동 로직 작성
  - [ ] 예외 처리

---

### 🗄 NoSQL DB 관련일 경우
- 컬렉션(Collection) 구조 예시:
```plaintext
users (Collection)
 └── {user_id} (Document)
      ├── name: string
      ├── email: string
      └── bookmarks (Subcollection)
           └── {bookmark_id}
                ├── postId: string
                ├── createdAt: timestamp
                └── note: string
```
- 변경 내용:
  - [ ] 새로운 컬렉션 추가  
  - [ ] 필드 추가 / 수정  
  - [ ] 데이터 구조 변경  
  - [ ] 인덱스 규칙 수정 (필요 시)

- 주의사항:
  > ex) 기존 데이터 마이그레이션 필요 여부 확인  
  > ex) 보안 규칙(Firebase Security Rules) 업데이트 필요  

---

## ✅ 완료 조건 (Acceptance Criteria)
이 이슈가 완료되었다고 판단할 수 있는 기준을 구체적으로 작성해주세요.

> ex) Firestore에 북마크 데이터가 정상적으로 추가/삭제되고, 앱 재시작 시 반영됨  
> ex) Security Rules에서 인증된 사용자만 접근 가능함

---

## 🔗 참고 자료 (References)
관련 문서, 설계 다이어그램, Firestore 콘솔 링크 등을 첨부해주세요.

> ex) #12, Firebase Rules 문서, ERD 다이어그램 링크

---

## 🧾 추가 메모 (Notes)
그 외 공유해야 할 내용이나 구현 시 유의사항을 작성해주세요.
