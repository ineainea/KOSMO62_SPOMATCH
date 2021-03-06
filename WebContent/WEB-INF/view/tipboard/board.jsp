<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팁공유게시판 목록</title>
<script type="text/javascript">
	$(function(){
		$("#insertForm").click(function(){
			location.href="/tipboard/insertForm.spo";
		});
		
		$(".goDetail").click(function(){
			var stb_no = $(this).parents("tr").attr("data-no");
			$("stb_no").val(stb_no);
			
			$("#detailForm").attr({
				"method":"get",
				"action":"/tipboard/boardDetail.spo"
			});
			$("#detailForm").submit();
		});
	});
</script>
</head>
<body>
<%@include file="../common/header.jsp" %>
<!-- Content -->
<section>
	<div class="container">
			<div id="boardContainer">
				<div id="boardTit"><h3>글목록</h3></div>
				<form name="detailForm" id="detailForm">
					<input type="hidden" name="stb_no" id="stb_no">
				</form>
				
				<div id="boardList">
				<table summary ="게시판 리스트">
					<colgroup>
						<col width="10%" />
						<col width="60%" />
						<col width="10%" />
						<col width="15%" />
						<col width="5%" />
					</colgroup>
					<thread>
						<tr>
							<th>글번호</th>
							<th>글제목</th>
							<th>작성자</th>
							<th>작성일자</th>
							<th>조회수</th>
						</tr>
					</thread>
					<tbody>
					<!-- 데이터출력 -->
					<c:choose>
						<c:when test="${not empty boardList}">
							<c:forEach items="${tipboardList}" var="board">
								<tr align="center" data-no="${board.stb_no}">
									<td>${board.stb_no}</td>
									<td align="left"><span class="goDetail">${board.stb_subject}</span></td>
									<td>${board.smb_id}</td>
									<td>${board.stb_insertdate}</td>
									<td>${board.stb_viewcnt}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4" align="center">
									등록된 게시물이 존재하지 않습니다.
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
					</tbody>
				    </table>
				</div>
				<div id="boardinsert" align="right" style="padding-right: 50px;">
					<input type="button" value="글쓰기" id="insertForm">
				</div>
			</div>
		</div>
	</section>
<%@include file="../common/footer.html" %>
</body>
</html>