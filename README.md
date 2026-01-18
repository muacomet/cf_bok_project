# CrossFit BOK | Flexible WOD Dashboard

이 프로젝트는 크로스핏 박스의 WOD(Workout of the Day)와 기록을 관리하고 디스플레이하기 위한 웹 시스템입니다.
Apache Tomcat 8.5 기반으로 구동되며, 파일 기반 데이터베이스(`data.json`)를 사용하여 가볍고 빠르게 동작합니다.

## 🔗 주요 접속 주소 (Access URLs)

서버 실행 후 브라우저에서 아래 주소로 접속하세요.

| 구분 | 주소 | 설명 |
| :--- | :--- | :--- |
| **관리자 페이지** | [`/admin.html`](http://localhost:18080/admin.html) | WOD 작성, 공지사항 수정, 회원 기록 입력 및 관리 |
| **메인 대시보드** | [`/index.html`](http://localhost:18080/index.html) | **(3단 레이아웃)** 상세 WOD 가이드 + 오늘의 훈련 요약 + 공지사항 |
| **기록 대시보드** | [`/index2.html`](http://localhost:18080/index2.html) | **(2단 레이아웃)** 오늘의 WOD + 회원별 기록 리스트 (Top Notice 포함) |

---

## 📖 사용 가이드 (User Manual)

### 1. 관리자 페이지 (Admin)
관리자는 여기서 모든 데이터를 통제합니다. 날짜를 선택하여 과거/미래의 데이터를 미리 세팅할 수 있습니다.

#### 📌 공통 조작
*   **Target Date**: 상단 날짜 선택기를 통해 편집할 날짜를 선택합니다. (변경 시 자동 조회)
*   **Excel 다운로드**: 해당 날짜의 기록 데이터를 CSV로 다운로드할 수 있습니다.

#### 📝 WOD 및 공지사항 설정
1.  **WOD Title**: 화면 왼쪽 상단에 표시될 제목입니다.
2.  **WOD Guide**: 전체 운동 내용을 입력합니다.
    *   `[next]` 입력 시 대시보드에서 줄바꿈이 적용됩니다.
    *   그 외 엔터키는 줄바꿈으로 인식합니다.
3.  **Today's Workout (요약)**: 중앙 컬럼에 표시될 핵심 요약 내용입니다.
4.  **Notices (공지사항)**: 우측 컬럼에 표시될 공지사항입니다.
    *   미입력 시 기본 안내 문구(QR코드 등)가 표시될 수 있으나, 현재는 빈 화면으로 나옵니다.
5.  **설정 저장 (Update) 버튼**: 위 1~4번 항목(텍스트 데이터)을 저장합니다. **기록은 저장되지 않습니다.**

#### 🏆 기록 추가 (Records)
1.  **이름 / 레벨 / 기록**: 선수의 이름과 레벨(Rx'd, A, B...), 기록을 입력합니다.
    *   *Tip*: 레벨 버튼(Rx'd, A, B...)을 누르면 자동으로 입력됩니다.
2.  **기록 등록 버튼**: 명단 리스트에 추가하고 즉시 서버에 저장합니다.
    *   ⚠️ **주의**: '설정 저장' 버튼을 누른다고 기록이 저장되지 않습니다. 반드시 '기록 등록'을 눌러주세요.
3.  **수정/삭제**: 하단 리스트에서 [수정], [삭제] 버튼을 통해 관리 가능합니다.

---

## 🛠 기술 스택 & 구조
- **Server**: Apache Tomcat 8.5 (JDK 8)
- **Frontend**: HTML5, TailwindCSS (CDN), Lucide Icons
- **Backend**: JSP (Java Server Pages)
- **Database**: `webapps/data.json` (JSON 파일 저장 방식)

### ⚙️ 데이터 저장 구조 (Data Flow)
1.  **Save**: Admin에서 저장 요청 -> `save_data.jsp` -> `data.json` 파일 덮어쓰기 (UTF-8)
2.  **Load**: Dashboard(`index.html`) -> 5초마다 `data.json` 변경 확인 -> 화면 갱신
3.  **Backup**: 데이터 저장 시 자동으로 `.bak` 파일 생성 (`database_backup` 폴더 적극 활용 권장)

## 🚀 실행 방법 (Docker)
맥(Mac) 또는 윈도우 환경에서 Docker Compose를 사용해 배포합니다.

```bash
# 실행
docker compose up -d

# 중지
docker compose down

# 로그 확인 (문제 발생 시)
docker compose logs -f
```

## ✅ 최근 업데이트 사항 (2026.01)
- **Admin 기능 강화**: WOD 요약 및 공지사항 별도 입력 기능 추가
- **UI 개선**: `index.html` 텍스트 정렬 및 불필요한 데코레이션 삭제
- **안정성 확보**: 데이터 저장 로직(`save_data.jsp`) 전면 재작성으로 저장 오류 해결
- **하이브리드 뷰**: `index2.html`에 공지사항 섹션 통합
- **모바일 최적화**: 상단 날짜 표시 중복 제거(큰 날짜로 통일) 및 정보 부재 시 안내 메시지 강화
