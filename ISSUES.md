# Resolved Issues

The following issues were identified and resolved during the recent development session. You can copy these to your GitHub Issues if needed.

## 1. Data Persistence Failure
**Title**: Fix data not saving to `data.json` due to path resolution mismatch
**Body**: 
> **Problem**: Changes made in the Admin panel were not persisting to `webapps/data.json` on the host machine.
> **Root Cause**: The JSP `application.getRealPath("/")` was resolving to `/usr/local/tomcat/webapps/` inside the container, but the application was mounted at `/usr/local/tomcat/webapps/ROOT/`. This caused the app to write to a hidden location instead of the mounted volume.
> **Fix**: Updated `save_data.jsp` to explicitly target `/data.json` and improved path resolution logic to handle the ROOT context correctly.
**Labels**: `bug`, `backend`, `high-priority`

## 2. Admin Page UX Improvements
**Title**: Enhance Admin Page with WOD Summary, Notices, and Safety Checks
**Body**:
> **Problem**: The Admin page lacked fields for "Today's Workout Summary" and "Notices", requiring manual JSON editing. Also, users could accidentally lose Record data if they clicked "Update Settings" instead of "Add Record".
> **Fix**: 
> 1. Added textarea fields for Summary and Notice to `admin.html`.
> 2. Updated `renderAdmin` to load existing data.
> 3. Added a warning alert if a user tries to save global settings while a drafted record exists in the input fields.
**Labels**: `enhancement`, `ui/ux`

## 3. Mobile Date Display Overlap
**Title**: Fix duplicate and overlapping date display on mobile header
**Body**:
> **Problem**: On mobile devices, both the PC version (large date) and Mobile version (small date) were visible or conflicting, causing layout issues.
> **Fix**: Removed the redundant mobile-specific date element. Updated the main date element to be responsive (`text-xl` on mobile, `text-3xl` on desktop).
**Labels**: `bug`, `ui`, `mobile`

## 4. Index Page Layout Alignment
**Title**: Align "Today's Workout" and "Notice" columns and remove placeholder text
**Body**:
> **Problem**: The text in the 2nd and 3rd columns of `index.html` was vertically misaligned due to different container structures. Also, the placeholder text "오늘의 훈련 내용 (상단 WOD 참조)" was deemed unnecessary.
> **Fix**: 
> 1. Standardized the HTML structure of the Notice column to match the Workout column.
> 2. Removed the placeholder text.
> 3. Implemented consistent "Empty State" messages ("등록된 훈련 내용이 없습니다." / "등록된 공지사항이 없습니다.").
**Labels**: `style`, `ui`

## 5. Server Configuration & Clean Up
**Title**: Optimize Server Configuration and Clean Up Legacy Files
**Body**:
> **Problem**: The project contained unused backup files and temporary test scripts (`write_test.jsp`, etc.). `server.xml` configuration was slightly ambiguous regarding the ROOT context.
> **Fix**: 
> 1. Verified `server.xml` and `compose.yaml` mappings.
> 2. Removed temporary debugging files.
> 3. Updated `README.md` with accurate path information and usage guides.
**Labels**: `chore`, `documentation`
