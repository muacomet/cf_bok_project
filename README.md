# CF BOK Project

이 프로젝트는 Apache Tomcat 8.5 기반의 Java 웹 애플리케이션입니다.
Docker Compose를 사용하여 간편하게 배포하고 실행할 수 있습니다.

## 🛠 기술 스택
- **Server**: Apache Tomcat 8.5 (JDK 8)
- **Language**: Java 8, JSP, HTML
- **Infrastructure**: Docker Compose
- **Database**: File-based storage (`data.json`)

## 🚀 실행 방법 (Local Development)

이 프로젝트는 로컬 개발 환경(Mac/Windows)에서 Docker를 통해 바로 실행할 수 있도록 설정되어 있습니다.

### 필수 조건
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) 설치

### 실행 명령어
터미널에서 프로젝트 루트 디렉토리로 이동 후 다음 명령어를 실행하세요.

```bash
docker compose up -d
```

서버가 실행되면 브라우저에서 아래 주소로 접속할 수 있습니다.
- http://localhost:18080

## 📂 프로젝트 구조 (Refactored)
- `webapps/ROOT/`: 웹 애플리케이션 루트 (기존 `webapps/` 내용을 이곳에 마운트)
  - `css/style.css`: 공통 스타일시트
  - `js/app.js`: 공통 JavaScript 로직
  - `save_data.jsp`: 데이터 저장 API (Refactored)
- `tomcat_conf/`: Tomcat 서버 설정 파일
- `compose.yaml`: Docker Compose 설정

## ✅ 최근 변경 사항 (Refactoring)
- **Frontend 모듈화**: 중복 코드를 `css/style.css`와 `js/app.js`로 분리하여 관리 효율성을 높였습니다.
- **Backend 정리**: `save_data.jsp`의 코드를 최신 Java 스타일로 개선하고 안정성을 확보했습니다.
- **배포 경로 단순화**: 앱이 `localhost:18080/` (Root Context)에서 바로 실행되도록 수정했습니다.
- **불필요 파일 제거**: 사용하지 않는 백업 파일 및 레거시 파일들을 정리했습니다.

## 📝 참고 사항
- **데이터 저장**: 데이터는 `webapps/data.json` 파일에 저장됩니다.
- **백업**: `save_data.jsp` 호출 시 자동으로 `.bak` 파일을 생성하며, 기존 날짜별 백업 로직은 정리되었습니다.
