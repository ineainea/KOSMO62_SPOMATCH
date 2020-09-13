<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="kosmo62.spomatch.apply.vo.SpoApplyVO"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>신청 리스트</title>
<link rel="stylesheet" type="text/css" href="/spoMatch/css/apply.css" />
<script type="text/javascript">
	$(document).ready(function() {
		/* =========== 상세보기 버튼 클릭 함수 ========== */
		$(".viewApplyBtn").click(function() {
			var clickVal= $(this);
			var tr = clickVal.parent().parent();
			var td = tr.children();
			$("#smc_no").val(td.eq(0).text());
			$("#sap_no").val(td.eq(1).text());
			console.log(td.eq(0).text());
			$("#viewApplyForm").attr({
				"enctype":"application/x-www-form-urlencoded",
				"method":"post",
				"action":"/spoMatch/viewApply.spo"
			}).submit();
		});
	});
</script>
</head>
<body>
<%@include file="../common/header.jsp" %>
<%
	Object obj = request.getAttribute("applyList");
	if(obj != null){
		List<SpoApplyVO> list = (List<SpoApplyVO>) obj;
%>
<section>
<div class="container">
<table>
	<tr>
		<td><h2>신청 리스트</h2></td>
	</tr>
</table>
<form id="viewApplyForm">
	<input type="hidden" id="smc_no" name="smc_no">
	<input type="hidden" id="sap_no" name="sap_no">
</form>
<p>총 <%=list.get(0).getSpg_totalSize() %>개의 신청</p>
<table class="matchList_table">
	<thead>
		<tr>
			<th>신청글 번호</th><!--  -->
			<th>번호</th><!--  -->
			<th>제목</th><!--  -->
			<th>거주지</th><!--  -->
			<th>아이디</th>
			<th>신청일</th>
			<th>수락여부</th>
			<th>상세보기</th>
		</tr>
	</thead>
	<tbody>
	<%	
		if(list != null && list.size() > 0){
			for(SpoApplyVO row : list){
	%>
		<tr>
			<td><%=row.getSmc_no() %></td>
			<td><%=row.getSap_no() %></td>
			<td><%=row.getSap_subject() %></td>
			<td><%=row.getSap_areaval() %></td>
			<td><%=row.getSmb_id() %></td>
			<td><%=row.getSap_insertdate() %></td>
			<td><%=row.getSap_acceptyn() %></td>
			<td><input type="button" class="viewApplyBtn" value="상세보기" /></td>
		</tr>
	<% 
			}
		} else { 
	%>
		<tr>
			<td colspan="7">
				등록된 데이터가 존재하지 않습니다.
			</td>
		</tr>
	<% } %>
	</tbody>
</table>
<%	
	if(list != null && list.size() > 0){
		SpoApplyVO svo = list.get(0);
%>
<div>
	<jsp:include page="../paging.jsp" flush="true">
		<jsp:param name="url" value="listApply.spo" />
		<jsp:param name="str" value="" />
		<jsp:param name="spg_pageSize" value="<%=svo.getSpg_pageSize() %>" />
		<jsp:param name="spg_totalSize" value="<%=svo.getSpg_totalSize() %>" />
		<jsp:param name="spg_groupSize" value="<%=svo.getSpg_groupSize() %>" />
		<jsp:param name="spg_curPage" value="<%=svo.getSpg_curPage() %>" />
	</jsp:include>
</div>
<% 		}
	} 
%>
</div>
</section>
<%@include file="../common/footer.html" %>
</body>
</html>