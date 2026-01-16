<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*, java.nio.file.*" %>
<%
    // 1. 요청(Request) 데이터 인코딩 설정
    request.setCharacterEncoding("UTF-8");

    // 2. 요청 바디(JSON 데이터) 읽기
    StringBuilder sb = new StringBuilder();
    try (BufferedReader reader = request.getReader()) {
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }
    }

    String filePath = application.getRealPath("/") + "data.json";
    File file = new File(filePath);
    File backupFile = new File(filePath + ".bak"); // 백업 파일 경로 (data.json.bak)

    try {
        // 3. 백업 로직 추가: 파일이 존재하면 쓰기 전에 복사함
        if (file.exists()) {
            // Java 7+ Files.copy를 사용하여 기존 파일을 백업본으로 교체(REPLACE_EXISTING)
            Files.copy(file.toPath(), backupFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // 4. 파일을 쓸 때 UTF-8을 명시적으로 지정
        try (OutputStreamWriter writer = new OutputStreamWriter(new FileOutputStream(file), "UTF-8")) {
            writer.write(sb.toString());
            response.setStatus(200);
            out.print("{\"status\":\"success\"}");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(500);
        // 에러 메시지 출력 (디버깅용)
        out.print("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
    }
%>