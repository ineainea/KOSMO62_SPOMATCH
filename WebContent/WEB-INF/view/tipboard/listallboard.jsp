<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kosmo62.spomatch.tipboard.vo.SpoTipBoardVO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<link href="css/tipboard/listallboard.css" rel="stylesheet" />
<title>팁공유게시판 전체목록</title>
<script type="text/javascript">

	$(document).ready(function(){
		//alert(">>>")
		
		//제목클릭 이벤트
		$(".goDetail").click(function(){
		var stb_no = $(this).parents("div").attr("data-no");
		
		$("#stb_no").val(stb_no);
	  //$("#smb_no").val(smb_no);
		//상세페이지로 이동
		$("#selectForm").attr({
			"method":"post",
			"action":"detailboard.spo"
		}).submit();
	  });//end of goDetail click 
	  
		$("#insertboard").click(function(){
			console.log("insertBoard value >>> " + $("#insertboard").val());
			$("#selectForm").attr("action","insertForm.spo");
			$("#selectForm").submit();
		});
		
	  
	  //검색버튼클릭이벤트
	  $("#searchbtn").click(function(){
		  //조회페이지로 이동
		  $("selectForm").attr({
			  "method":"post", 
			  "action":"listallboard.spo"
		  });
		  $("#selectForm").submit();
	  });//end of searchbtn click
	  
	  //카테고리 변경
	  $("#stb_category").change(function(){
		  console.log("category value>>>" + $("#stb_category").val());
		  //조회페이지로 이동
		  $("#selectForm").attr({
			  "method":"post", 
			  "action":"listallboard.spo"
		  });
		  $("#selectForm").submit();
	  });//end of stb_category change 


		
	});//end of ready
</script>
</head>

<body>
<%@include file="../common/header.jsp" %>
<!-- Content -->
<section>
	<div class="container">
		<h1>팁공유게시판</h1>
		<div class="board">
			<form name="boardForm" id="boardForm" method="post">
			<!-- 카테고리, 제목(+작성자), 검색부분 -->
			<div class="sub">
				<!-- 카테고리, 제목(+작성자) -->
				<div class="sub_category_subject">
					<!-- 카테고리 -->
					<div class="sub_category">
						<select name="stb_category" id="stb_category" >
							<option value="전체">전체</option>
							<option value="루틴">루틴</option>
							<option value="축구">축구</option>
						    <option value="야구">야구</option>
						    <option value="농구">농구</option>
						    <option value="기타">기타</option>
						</select>
					</div>
				</div>
					<!-- 제목(+작성자) -->
					<div class="sub_subject">
						<select name="searchFilter" id="searchFilter">
							<option value="제목">제목</option>
							<option value="내용">내용</option>
							<option value="제목+내용">제목+내용</option>
						</select>
					</div>
					 <div class="sub_search">
						<input type="text" name="keyword" id="keyword" placeholder="검색어 입력" size="30px">
						<input type="button" class="searchbtn" id="searchbtn" value="검색"> 
						<input type="hidden" id="page" name="page">
					 </div>
			</div>
	<%
		Object obj = request.getAttribute("listallboard");
		if(obj !=null )	{
		List plist = (List)obj;
		if(plist.size() > 0){
			SpoTipBoardVO stvo = (SpoTipBoardVO)plist.get(0);
		%>	
			<div class="sub_total_insertbtn">
					 <span class="sub_total">총 <%= stvo.getSpg_totalSize() %>개 게시글</span>
			</div>
		<%
			}else{	
		
%>
			<div class="sub_zero_insertbtn">
				<span class="sub_zero">총 0개 게시글</span>
			</div>
<%				
		}
	}
		%>
</form>
<!-- 게시물 부분 -->
		<div>
		<form class="selectForm" name="selectForm" id="selectForm" method="post">
			<input type="hidden" name="stb_no" id="stb_no">
		</form>
		<div class="board">
		<div class="board_info">
			 <div class="info info_num" style="width: 8%;">글번호</div>
			 <div class="info info_memnum" style="width: 10%;">회원번호</div>
			 <div class="info info_author" style="width: 10%;">작성자</div>
			 <div class="info info_category" style="width: 8%;">카테고리</div>
			 <div class="info info_subject" style="width: 23%;">제목</div>
			 <div class="info info_pw" style="width: 4%;">비밀번호</div>
			 <div class="info info_view" style="width: 7%;">조회수</div>
			 <div class="info info_good" style="width: 6%;">좋아요</div>
			 <div class="info info_shareYN" style="width: 4%;">공유여부</div>
			 <div class="info info_deleteYN" style="width: 4%;">삭제여부</div>
			 <div class="info info_inserdate" style="width: 12%;">작성일</div>
			 <div class="info info_updatedate" style="width: 11%;">수정일</div>	
		</div>
<%
		
		if(obj != null){
			List list = (List)obj;
			int nCnt = list.size();
			if(nCnt > 0){
				for(int i = 0; i < nCnt; i++){
					SpoTipBoardVO param = (SpoTipBoardVO)list.get(i);
	
		
%>

		   <div class="board_content" data-no ="<%= param.getStb_no() %>">
				<div class="content content_num" style="width: 8%;"><%= param.getStb_no() %></div>
				<div class="content content_memnum" style="width: 11%;"><%= param.getSmb_no() %></div>
				<div class="content content_author" style="width: 10%;"><%= param.getSmb_id() %></div>
				<div class="content content_category" style="width: 8%;"><%=param.getStb_category() %></div>
				<div class="content content_subject goDetail" style="width: 25%;"><%= param.getStb_subject() %></div>
				<div class="content content_pw" style="width: 6%;"><%= param.getStb_pw() %></div>
				<div class="content content_view" style="width: 6%;"><%= param.getStb_viewcnt() %></div>
				<div class="content content_good" style="width: 6%;"><%= param.getStb_goodcnt() %></div>
				<div class="content content_shareYN" style="width: 5%;"><%= param.getStb_shareyn() %></div>
				<div class="content content_deleteYN" style="width: 5%;"><%= param.getStb_deleteyn() %></div>
				<div class="content content_inserdate" style="width: 12%;"><%= param.getStb_insertdate() %></div>
				<div class="content content_updatedate" style="width: 12%;"><%= param.getStb_updatedate() %></div>
				
			</div>
					
				
<%
				}
			}
		}else{
%>
						<div class="board_nondate">
							<span>등록된 데이터가 존재하지 않습니다...😥</span>
						</div>
						<div>
<%
		}
		if(obj !=null )	{
			List list = (List)obj;
			int cnt = list.size();
			if(cnt > 0){
			SpoTipBoardVO svo = (SpoTipBoardVO)list.get(0);
		
%>
					<div class = "paging-Area">
							<jsp:include page="../tipboard/paging.jsp" flush="true">
								<jsp:param name="url" value="listallboard.spo" />
								<jsp:param name="str" value="" />
								<jsp:param name="spg_pageSize" value="<%= svo.getSpg_pageSize() %>" />
								<jsp:param name="spg_groupSize" value="<%= svo.getSpg_groupSize() %>" />
								<jsp:param name="spg_curPage" value="<%= svo.getSpg_curPage() %>" />
								<jsp:param name="spg_totalSize" value="<%= svo.getSpg_totalSize() %>" />
							</jsp:include>
					</div>
		<%
					}else{
		%>
						<div class="board_nondate">
							<span>등록된 데이터가 존재하지 않습니다...😥</span>
						</div>
						<%
					}
			}
				
				%>
		</div>
		</div>
	</div>
	</div>
</div>
</section>
<%@include file="../common/footer.html" %>
</body>
</html>