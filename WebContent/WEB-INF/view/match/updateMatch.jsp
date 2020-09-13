<%@page import="kosmo62.spomatch.match.vo.SpoMatchVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>매칭 수정</title>
<link rel="stylesheet" type="text/css" href="css/match/updateMatch.css" />
<% 
	Object obj = request.getAttribute("SpoMatchVO");
	SpoMatchVO svo = (SpoMatchVO)obj;
%>	
<script type="text/javascript">
	$(document).ready(function() {
		$( "#smc_date" ).datepicker();
	    $( "#smc_date" ).datepicker("option","dateFormat","yy-mm-dd");
	    $( "#smc_date" ).val('<%=svo.getSmc_date()%>');
	    setMaxapl();
	    setCategory();
	    setTime();
		
	});
	
	
	
	  /* 인원 수 설정 함수*/
	  function setMaxapl() {
		  $("#smc_maxapl").empty();
			for(var j= 1; j<=10; j++){
				$("#smc_maxapl").append("<option value="+j+">" + j + "</option>");
			}
			/* default 값 설정 */
			$("#smc_maxapl").val('<%=svo.getSmc_maxapl()%>');
	  }
	  
	  /* 카테고리 설정 함수*/
	  function setCategory(){
		  $('input:radio[name="smc_category"]:input[value="<%=svo.getSmc_category() %>"]').prop("checked", true);
	  }
	  
	  /* 시간 설정  함수 */
	  function setTime(){

		$("#smc_sttime2").empty();
		$("#smc_endtime2").empty();
		for(var i= 1; i<=24; i++){
			if(i >= 10){
				$("#smc_sttime1").append("<option value="+i+">"+ i + "</option>");
				$("#smc_endtime1").append("<option value="+i+">"+ i + "</option>");
			}else{
				$("#smc_sttime1").append("<option value='0"+i+"'>0" + i + "</option>");
				$("#smc_endtime1").append("<option value='0"+i+"'>0" + i + "</option>");
			}
		}
		for(var i= 0; i<=5; i++){
			$("#smc_sttime2").append("<option value="+i+"0>" + i + "0</option>");
			$("#smc_endtime2").append("<option value="+i+"0>" + i + "0</option>");
		}
	
		
		/* default 값 설정 */
		var t1 = '${SpoMatchVO.smc_sttime}'.split(':');
		$("#smc_sttime1").val(t1[0]);
		$("#smc_sttime2").val(t1[1]);
		var t2 = '${SpoMatchVO.smc_endtime}'.split(':');
		$("#smc_endtime1").val(t2[0]);
		$("#smc_endtime2").val(t2[1]);
	  }
	  
	  function updateMatch(no){
		  if(confirm('수정하시겠습니까?')){
			$("#smc_no").val(no);
			$("#smc_sttime").val($("#smc_sttime1").val() + ':' + $("#smc_sttime2").val());
			$("#smc_endtime").val($("#smc_endtime1").val() + ':' + $("#smc_endtime2").val());
			$("#updateForm").attr("action","updateMatch.spo");
			$("#updateForm").submit();
		  }
		}
	  function listGo(){
		  if(confirm('취소하시겠습니까?')){
			$("#smc_no").val(no);
			$("#updateForm").attr("action","viewMatch.spo");
			$("#updateForm").submit();
		  }
		}
</script>
</head>
<body>
<%@include file="../common/header.jsp" %>
<!--******************************************Content******************************************-->
<section>
    <div class="container">
			<% 
				obj = request.getAttribute("SpoMatchVO");
				if(obj != null){
					svo = (SpoMatchVO)obj;
					if(svo != null){
			%>
			<h1>매칭 수정</h1>
			<form  name="updateForm" id="updateForm" method="post">
				<input type="hidden" name="smc_no" id="smc_no" value="<%=svo.getSmc_no() %>"/>
					<div class="spoMatchForm_item">
						<div class="item_name ness">작성자</div>
						<div  class="item_content">
							<input type="text" name="smc_id" id="smc_id" value="<%=svo.getSmb_id() %>" readonly/>
						</div>
					</div>
					<div class="spoMatchForm_item">
						<div class="item_name ness">제목</div>
						<div  class="item_content">
							<input type="text" name="smc_subject" id="smc_subject" value="<%=svo.getSmc_subject() %>" />
						</div>
					</div>
					<div class="spoMatchForm_item">
						<div class="item_name ness">종목</div>
						<div class="item_content">
							<input type="radio" name="smc_category" id="smc_category" value="01">
							<label for="Soccer">축구</label>
							<input type="radio" name="smc_category" id="smc_category" value="02">
							<label for="BasketBall">농구</label>
							<input type="radio" name="smc_category" id="smc_category" value="03">
							<label for="BaseBall">야구</label>
							<input type="radio" name="smc_category" id="smc_category" value="00">
							<label for="Soccer">기타</label>
						</div>
					</div>
					<div class="spoMatchForm_item">
						<div class="item_name ness">지역</div>
						<div class="item_content">
							<select name="smc_local" id="smc_local" value="<%=svo.getSmc_local() %>">
							    <option value="01">서울</option>
							    <option value="02">경기</option>
							    <option value="03">인천</option>
							 </select>
						</div>
					</div>
					<div class="spoMatchForm_item">
						<div class="item_name ness">인원</div>
						<div class="item_content">
							<select name="smc_maxapl" id="smc_maxapl">
							</select>명
						</div>
					</div>
					<div class="spoMatchForm_item">
						<div class="item_name ness">날짜</div>
						<div class="item_content">
							<p><input type="text" name="smc_date" id="smc_date" value="<%=svo.getSmc_date() %>" readonly></p>
						</div>
					</div>
					<div class="spoMatchForm_item">
						<div class="item_name ness">시간</div>
						<div class="item_content">
							<input type="hidden" name="smc_sttime" id="smc_sttime">
							<input type="hidden" name="smc_endtime" id="smc_endtime">
							 <select name="smc_sttime1" id="smc_sttime1">
							 </select>시
							 <select name="smc_sttime2" id="smc_sttime2">
							 </select>분 ~ 
							 <select name="smc_endtime1" id="smc_endtime1">
							 </select>시
							 <select name="smc_endtime2" id="smc_endtime2">
							 </select>분
						</div>
					</div>
					<div class="spoMatchForm_item item_content">
						<div class="item_name ness">기타사항</div>
						<div class="item_content">
							<textarea rows="20" cols="100" id="smc_content" name="smc_content"><%=svo.getSmc_content() %></textarea>
						</div>
					</div>
				</form>
				<div class="insert insert_subbtn" align="center">
					<button class="btn btn-info" onclick="updateMatch('<%=svo.getSmc_no() %>')">수정</button>
					<button class="btn btn-neutral" name="listMatch" id="listMatch" onclick="listGo('<%=svo.getSmc_no() %>')">취소</button>
				</div>
			<% 
					}
				}
			%>
		</div>
	</section>	
<!--******************************************End of Content******************************************-->
<%@include file="../common/footer.html" %>
</body>
</html>