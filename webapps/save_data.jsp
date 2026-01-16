<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.io.*, java.util.*, java.nio.file.*" %>
        <% // 1. 요청(Request) 데이터 인코딩 설정 request.setCharacterEncoding("UTF-8");
            response.setContentType("application/json; charset=UTF-8"); // 2. 요청 바디(JSON 데이터) 읽기 StringBuilder sb=new
            StringBuilder(); try (BufferedReader reader=request.getReader()) { String line; while
            ((line=reader.readLine()) !=null) { sb.append(line); } } catch (IOException e) { response.setStatus(400);
            out.print("{\"status\":\"error\", \"message\":\"Failed to read request body\"}"); return; } String
            filePath=application.getRealPath("/") + "data.json" ; File file=new File(filePath); File backupFile=new
            File(filePath + ".bak" ); try { // 3. 백업 로직: 파일이 존재하면 백업 if (file.exists()) { Files.copy(file.toPath(),
            backupFile.toPath(), StandardCopyOption.REPLACE_EXISTING); } // 4. 데이터 저장 (UTF-8) try (OutputStreamWriter
            writer=new OutputStreamWriter(new FileOutputStream(file), "UTF-8" )) { writer.write(sb.toString()); }
            response.setStatus(200); out.print("{\"status\":\"success\"}"); } catch (Exception e) { e.printStackTrace();
            response.setStatus(500); // JSON 문자열 이스케이프 처리가 없으므로 간단한 메시지만 반환 out.print("{\"status\":\"error\",
            \"message\":\"Internal Server Error\"}"); } %>