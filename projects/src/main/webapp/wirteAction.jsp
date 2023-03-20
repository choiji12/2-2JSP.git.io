<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> 
<%@ page import="java.io.PrintWriter" %> <!-- 자바스크립트문을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %> <!-- 모든 데이터를 UTF-8로 받음 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" /> 

<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판!!</title>
</head>
<body>

	
	<%

	String userID = null;
	if(session.getAttribute("userID") != null){
		
		userID = (String) session.getAttribute("userID");
		
	}
	if(userID == null){
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href ='login.jsp'");
		script.println("</script>");
		
		
	}else{
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null ) 
            //제목이나 내용을 입력하지 않은경우는 오류발생
					{
					 PrintWriter script = response.getWriter();
					 script.println("<script>");
					 script.println("alert('제목이나 내용을 확인하세요!')");
					 script.println("history.back()"); 
					 script.println("</script>");
					}
					else{
						
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); 
					
					 if(result == -1)
					 {
						 PrintWriter script = response.getWriter();
						 script.println("<script>");
						 script.println("alert('글쓰기에 실패했습니다.')");
						 script.println("history.back()"); //이전 페이지로 돌려보냄(join 페이지)
						 script.println("</script>"); 
					 }
					//DB를 생성할때 PRIMARY값으로 userID를 주었기 때문에, 동일한 아이뒤는 생성불가
					 
					 else 
					 {
						 PrintWriter script = response.getWriter();
						 script.println("<script>");
						 script.println("location.href = 'bbs.jsp'"); //회원가입이 된경우 => main.jsp 페이지로 이동
						 script.println("</script>");
					 }
					}
		}
		
	
		
	%>
</body>
</html>