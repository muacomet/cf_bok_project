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

## 📂 프로젝트 구조
- `webapps/`: 웹 애플리케이션 소스 코드 (JSP, HTML, JSON 데이터)
- `tomcat_conf/`: Tomcat 서버 설정 파일
- `compose.yaml`: Docker Compose 설정 (로컬 실행용으로 수정됨)

## 📝 참고 사항
- **데이터 저장**: 데이터는 `webapps/data.json` 파일에 저장되며, `database_backup/` 폴더에 백업됩니다.
- **수정 이력**: 2026-01-17: 로컬 실행 지원을 위해 `compose.yaml`의 절대 경로를 상대 경로로 수정하고, 외부 네트워크 의존성을 제거했습니다.
