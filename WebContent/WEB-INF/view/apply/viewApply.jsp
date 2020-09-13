<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kosmo62.spomatch.apply.vo.SpoApplyVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" type="text/css" href="css/apply/viewApply.css" />
<title>view Detail Apply</title>
<!-- sap_no의 작성자로 로그인 되어 있을 경우 -->
<script type="text/javascript">
	$(document).ready(function() {
		/* ============ 수정버튼 함수 ============ */
		$("#updateApplyBtn").click(function(){
			$("#viewForm").attr({
				"method":"post",
				"enctype":"application/x-www-form-urlencoded",
				"action":"/spoMatch/updateFormApply.spo"
			}).submit();
		});
		/* ============ 삭제버튼 함수 ============ */
		$("#deleteApplyBtn").click(function(){
			$("#viewForm").attr({
				"method":"post",
				"enctype":"application/x-www-form-urlencoded",
				"action":"/spoMatch/deleteApply.spo"
			}).submit();
		});
	
		/*       smc_no의 작성자로 로그인 되어 있을 경우
			============ 수락버튼 함수 ============     */
		$("#acceptApplyBtn").click(function(){
			$("#sap_acceptyn").val("Y");
			$("#viewForm").attr({
			"method":"post",
			"enctype":"application/x-www-form-urlencoded",
			"action":"/spoMatch/acceptApply.spo"
			}).submit();
		});
		/* ============ 거절버튼 함수 ============ */
		$("#refuseApplyBtn").click(function(){
			$("#sap_acceptyn").val("N");
			$("#viewForm").attr({
			"method":"post",
			"enctype":"application/x-www-form-urlencoded",
			"action":"/spoMatch/acceptApply.spo"
			}).submit();
		});
		/* ============ 목록버튼 함수 ============ */
		$("#listApplyBtn").click(function(){
			$("#viewForm").attr({
				"method":"post",
				"enctype":"application/x-www-form-urlencoded",
				"action":"/spoMatch/listMatch.spo"
			}).submit();
		});
	});
</script>
</head>
<body>
<%@include file="../common/header.jsp" %>
<!-- Content -->
<section>
	<div class="container">
		<%
			Object obj = request.getAttribute("spoApplyVO");
			if(obj != null){
				SpoApplyVO svo = (SpoApplyVO)obj;
		%>
		<h1>신청서 보기</h1>
		<form id="viewForm">
			<input type="hidden" id="smb_no" name="smb_no" value="<%=svo.getSmb_no() %>">
			<input type="hidden" id="smc_no" name="smc_no" value="<%=svo.getSmc_no() %>">
			<input type="hidden" id="sap_no" name="sap_no" value="<%=svo.getSap_no() %>">
			<input type="hidden" id="sap_acceptyn" name="sap_acceptyn" value="<%=svo.getSap_acceptyn() %>">
		</form>
		<div class="card">
		<table class="viewMatchTable">
			<tr>
				<td>
					<div class="form-group">
						<label class="form-label">글번호<span class="form-required">*</span></label>
   						<input type="text" class="form-control" value="<%=svo.getSap_no() %>" readonly>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="form-group">
						<label class="form-label">제목<span class="form-required">*</span></label>
	  						<input type="text" class="form-control" value="<%=svo.getSap_subject()%>" readonly>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="form-group">
						<label class="form-label">아이디</label>
	  						<input type="text" class="form-control" value="<%=svo.getSmb_id()%>" readonly>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="form-group">
						<label class="form-label">지역(거주지)</label>
						<input type="text" class="form-control" value="<%=svo.getSap_areaval() %>" readonly>
					</div>
				</td>
			</tr>
			<tr>
			<%   
				String acceptYN =  svo.getSap_acceptyn();
				if(acceptYN.equals("Y")){
					acceptYN = "수락 완료";
				}else if(acceptYN.equals("W")){
					acceptYN = "대기 중";
				}else{
					acceptYN = "거절";
				}
			%>
				<td>
					<div class="form-group">
						<label class="form-label">수락여부</label>
						<input type="text" class="form-control" value="<%=acceptYN %>" readonly>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div class="form-group">
						<label class="form-label">간단 소개<span class="form-required">*</span></label>
						<textarea rows="25" cols="100" class="form-control" readonly><%=svo.getSap_introduce() %></textarea>
					</div>
				</td>
			</tr>
		</table>
		</div>

		<div align="center">
		<span>
	<%	
			String session_member = String.valueOf(session.getAttribute("smb_no"));
			// 신청글 등록자일 경우 
			if(svo.getSmb_no().equals(session_member)){ 
				if(svo.getSap_acceptyn().equals("W")){	%>
				<input type="button" class="btn btn-1 btn-primary" value="수정" id="updateApplyBtn">
	<% 			} %>
				<input type="button" class="btn btn-1 btn-primary" value="신청취소" id="deleteApplyBtn">
				<input type="button" class="btn btn-1 btn-neutral" value="목록" id="listApplyBtn">
			</span>
	<%
			}else if(svo.getMatch_writer().equals(session_member)){
			//매칭글 등록자일 경우
				if(svo.getSap_acceptyn().equals("W")){
	%>
				<input type="button" class="btn btn-1 btn-primary" value="수락" id="acceptApplyBtn">
				<input type="button" class="btn btn-1 btn-primary" value="거절" id="refuseApplyBtn">
	<%
			}
	%>
				<input type="button" class="btn btn-1 btn-neutral" value="목록" id="listApplyBtn">
	<%
			}
	%>
		</div>
	<%
			}
	%>
	</div>
</section>
<%@include file="../common/footer.html" %>
</body>
</html>