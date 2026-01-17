<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.io.*" %>
        <%@ page import="java.nio.file.*" %>
            <% request.setCharacterEncoding("UTF-8"); response.setContentType("application/json; charset=UTF-8"); /* 1.
                Read Body */ StringBuilder sb=new StringBuilder(); try (BufferedReader r=request.getReader()) { String
                line; while ((line=r.readLine()) !=null) { sb.append(line); } } catch (Exception e) {
                response.setStatus(400); out.print("{\"status\":\"error\"}"); return; } String c=sb.toString();
                if(c.trim().length()==0) { response.setStatus(400); out.print("{\"status\":\"empty\"}"); return; } /* 2.
                Path */ String tp=application.getRealPath("/data.json"); if(tp==null) { tp=application.getRealPath("/")
                + "data.json" ; } File f=new File(tp); File bf=new File(tp + ".bak" ); try { if (f.exists()) { try {
                Files.copy(f.toPath(), bf.toPath(), StandardCopyOption.REPLACE_EXISTING); } catch (Exception x) {} } try
                (OutputStreamWriter w=new OutputStreamWriter( new FileOutputStream(f), "UTF-8" )) { w.write(c); }
                response.setStatus(200); out.print("{\"status\":\"success\"}"); } catch (Exception e) {
                e.printStackTrace(); response.setStatus(500); out.print("{\"status\":\"fail\"}"); } %>