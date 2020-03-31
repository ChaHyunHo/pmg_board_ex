<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function() {
		boardList(1); 

		<%-- 게시물 등록 --%>
		$(document).on( "click", "#boardRegBtn", function() {
			var check = valicheck();
			var board = check(); // 클로저 함수로 가지고온 내부 리터럴 변수값 
			
			  $.ajax({
			        type : "POST",
			        url : "/board/register",
			        data : board,
			        success : function(data) {
				        alert("등록되었습니다.");
				        boardList(1);
			        },
			        error : function() {
			            alert('등록 실패');
			        }
			  });
		});

		$(document).on( "click","#registerListGo", function() {
			boardList(1);
		});

		<%-- 게시물 수정 --%>
		$(document).on( "click", "#boardUpRegBtn", function() {
			var check = valicheck();
			var board = check(); // 클로저 함수로 가지고온 내부 리터럴 변수값 

	       	$.ajax({
		        type : "POST",
		        url : "/board/update",
		        data : board,
		        success : function(data) {

			        alert("수정되었습니다");
			        
			        $('.container-fluid').html(data);
			        $("#searchTitle").val(board.searchTitle);
					$("#perPageBtn").val(board.perPageNum).prop("selected", true);
					$("#searchType").val(board.searchType).prop("selected", true);

					if(board.myBoardIdx == null || board.myBoardIdx == "" || typeof board.myBoardIdx == "undefined" ){
						$("#myBoardId").prop("checked", false);
					} else {
						$("#myBoardId").prop("checked", true);
						$("#tempIdx").val(board.myBoardIdx);
					}
		        },
		        error : function(error) {
		            alert(error);
		        }
			});
		});

		<%-- 게시물 삭제 --%>
		$(document).on( "click", "#boardDelBtn", function() {
			var bno = $("#b_n").val();
			var page = $("#pageGetInfo").val();
			var searchTitle = $("#getSearchTitle").val();
			var searchType = $("#getSearchType").val();
			var perPage = $("#getPerPageNum").val();
			var orderVal  = $("#orderVal").val();
			var myIdx = $("#myIdx").val();
	
			var info = {
					bno         : bno,
					page        : page,
					searchTitle : searchTitle,
					searchType  : searchType,
					perPageNum  : perPage,
					myBoardIdx  : myIdx
				};
	
			var result = confirm("삭제하시겠습니까?");
	
			if(result) {
				$.post( "/board/delete",
						{
							bno        : bno,
							page       : page,
							searchTitle: searchTitle,
							searchType : searchType,
							perPageNum : perPage,
							order      : orderVal ,
							myBoardIdx : myIdx
						}, function(data) {
							
						 alert("삭제되었습니다.");
						 
						 $('.container-fluid').html(data);
						 $("#searchTitle").val(searchTitle);
						 $("#perPageBtn").val(perPage).prop("selected", true);
						 $("#searchType").val(searchType).prop("selected", true);
						 
						 if(myIdx == null || myIdx == "" || typeof myIdx == "undefined" ){
							 $("#myBoardId").prop("checked", false);
						 } else {
							 $("#myBoardId").prop("checked", true);
							 $("#tempIdx").val(myIdx);
						 }
				});
			}
		});

		<%-- 게시글 상세 페이지 이동 --%>
		$(document).on("click", "#board_title", function() {
			var $this = $(this);
			var bno = $this.parent().parent().next().val();
			var page = $("#pageInfo").val();
			var searchTitle = $("#searchVal").val();
			var searchType = $("#searchTypeVal").val();
			var perPage = $("#perPageInfo").val();
			var orderVal = $("#orderVal").val();
			var myIdx = $("#tempIdx").val();

			// 공지사항 bno 가져오기
			if(typeof bno =="undefined" || bno == "" || bno == null) {
				bno = $this.parent().prev().data("bno");
			}

			var info = {
					bno         : bno,
					page        : page,
					searchTitle : searchTitle,
					perPageNum  : perPage,
					searchType  : searchType,
					order       : orderVal,
					myBoardIdx  : myIdx
				};
			
			$.ajax({
		        type : "GET",
		        url : "/board/dynamic/boardgetform",
		        dataType : "html",
		        data : info,
		        success : function(data) {
		        	$('.container-fluid').html(data);
		        },
		        error : function() {
		            alert('실패');
		        }
		  	});
		});

		<%-- 페이지 이동 --%>
		$(document).on("click", "#pageIndex", function() {
			var index = $(this).text();
			boardList(index);
		});

		$(document).on("click","#nextBtn", function() {
			var endPage = $("#pageEnd").val();
			boardList(parseInt(endPage) + 1);
		});

		$(document).on("click","#prevBtn", function() {
			var startPage = $("#pageStart").val();
			boardList(parseInt(startPage) - 1);
		});

		<%-- 게시물 등록 page 이동 --%>
		$(document).on("click", "#boardRegMove", function() {
			 $.ajax({
			        type : "GET",
			        url : "/board/dynamic/boardreg",
			        dataType : "html",
			        error : function() {
			            alert('실패');
			        },
			        success : function(data) {
			        	$('.container-fluid').html(data);
			        	$("#b_t").focus();
			        }
			  });
		});

		<%--  게시글 수정 page 이동 --%>
		$(document).on("click", "#boardUpBtn", function() {
			var passwordVal = $("#u_b_p").val();
			var bno = $("#b_n").val();
			var page = $("#pageGetInfo").val();
			var searchTitle = $("#getSearchTitle").val();
			var searchType = $("#getSearchType").val();
			var perPage = $("#getPerPageNum").val();
			var orderVal = $("#orderVal").val();
			var myBoardIdx = $("#myIdx").val();

			// 수정페이지 이동시 현재 내용의 길이 표시
			var contentLen = $("#b_c").val().length;

			var info = {
					bno         : bno,
					page        : page,
					searchTitle : searchTitle,
					searchType  : searchType,
					perPageNum  : perPage,
					order       : orderVal,
					myBoardIdx  : myBoardIdx
				}
			$.ajax({
		        type : "GET",
		        url : "/board/dynamic/boardupdateform",
		        dataType : "html",
		        data : info,
		        success : function(data) {
		        	$('#exampleModal').hide();
		        	$('.container-fluid').html(data);
		        	$("#b_t").focus();
		        	$("#contentLen").text(contentLen);
		        },
		        error : function() {
		            alert('실패');
		        }
		  	});
		});	

		<%-- 게시물 목록 가기 --%>
		$(document).on("click", "#resetId", function() {
		 	var page = $("#pageGetInfo").val();
			var perPage = $("#getPerPageNum").val();
			var searchType = $("#getSearchType").val();
			var orderVal = $("#orderVal").val();
			var myIdx = $("#myIdx").val();

			var search = {
							searchTitle : $("#getSearchTitle").val(),
							searchType  : searchType,
							perPageNum  : perPage,
							order       : orderVal,
							myBoardIdx  : myIdx
							
						 }; 
			 $.ajax({
			        type : "GET",
			        url : "/board/dynamic/boardlist/"+page,
			        dataType : "html",
			        data : search,
			        error : function() {
			            alert('실패');
			        },
			        success : function(data) {
			            $('.container-fluid').html(data);
			            $("#searchTitle").val(search.searchTitle);
			            $("#perPageBtn").val(perPage).prop("selected", true);
			            $("#searchType").val(search.searchType).prop("selected", true);
			            
			            if(myIdx == null || myIdx == "" || typeof myIdx == "undefined" ){
							 $("#myBoardId").prop("checked", false);
						 } else {
							 $("#myBoardId").prop("checked", true);
						 }
			        }
			  });
		});

		<%-- 게시글 검색 --%>
		$(document).on("keydown", "#searchTitle", function(e) {
			var type = $("#searchType").val();
			var perPage = $("#perPageInfo").val();
			var orderVal = $("#orderVal").val();
			var myBoardIdx = $("#tempIdx").val();
			var search = {
					searchTitle : $(this).val(),
					perPageNum  : perPage,
					searchType  : type,
					order       : orderVal,
					myBoardIdx  : myBoardIdx
			};

			// 검색 엔터키
			if(e.keyCode == 13) {
				commonSearch(type, perPage, search);
			}
		});
		
		// 검색 클릭 
		$(document).on("click", "#searchBtn", function() {
			var type = $("#searchType").val();
			var perPage = $("#perPageInfo").val();
			var orderVal = $("#orderVal").val();
			var myBoardIdx = $("#tempIdx").val();
			var search = {
					searchTitle : $(this).parent().prev().val(),
					perPageNum  : perPage,
					searchType  : type,
					order       : orderVal,
					myBoardIdx  : myBoardIdx
			}; 
			
			commonSearch(type, perPage, search);
		})
		
		// 내글만 보기
		$(document).on("click", '#myBoardId', function() {
			var $this = $(this);
			var type = $("#searchType").val();
			var perPage = $("#perPageInfo").val();
			var orderVal = $("#orderVal").val();
			var searchTitle = $("#searchVal").val();
			var page = $("#pageInfo").val();
			var myBoardIdx = $("#myIdx").val();
			
			if($this.is(":checked")) {
				 $.ajax({
				        type : "GET",
				        url : "/board/dynamic/boardlist/"+page,
				        dataType : "html",
				        data : {
					       		page 		: page,
					       		perPageNum  : perPage,
					        	searchTitle : searchTitle,
					        	searchType  : type,
					        	order       : orderVal,
					        	myBoardIdx  : myBoardIdx
					        	},
				        error : function() {
				            alert('실패');
				        },
				        success : function(data) {
				            $('.container-fluid').html(data);
				            $("#searchTitle").val(searchTitle);
				            $("#perPageBtn").val(perPage).prop("selected", true);
				            $("#searchType").val(type).prop("selected", true); 
				            if(myBoardIdx == null || myBoardIdx == "" || 
						            typeof myBoardIdx == "undefined" ){
								 $("#myBoardId").prop("checked", false);
							 } else {
								 $("#myBoardId").prop("checked", true);
							 }
				        }
				  });
				
			} else {
				$("#tempIdx").val("");
				boardList(page);
			}
		});

		<%-- 게시글 내용 글자수 확인 --%>
		$(document).on( "keyup", "#b_c", function() {
			var $contentLen = $("#contentLen");
			var cnt = $(this).val().trim().length;

			$contentLen.html(cnt);
		});

		<%-- 게시글 몇개씩 보일지 설정 --%>
		$(document).on( "change", "#perPageBtn", function() {
			var searchTitle = $("#searchVal").val();
			var searchType = $("#searchTypeVal").val();
			var perPage = $(this).val();
			var page = $("#pageInfo").val();
			var orderVal = $("#orderVal").val();
			var myBoardIdx = $("#tempIdx").val();

			$.ajax({
			        type : "GET",
			        url : "/board/dynamic/boardlist/"+page,
			        dataType : "html",
			        data :{
				        	perPageNum  : perPage,
				        	searchTitle : searchTitle,
				        	searchType  : searchType,
				        	order       : orderVal,
				        	myBoardIdx  : myBoardIdx
				          },
			        error : function() {
			            alert('실패');
			        },
			        success : function(data) {
			            $('.container-fluid').html(data);
			            $("#searchTitle").val(searchTitle);
			            $("#perPageBtn").val(perPage).prop("selected", true);
			            $("#searchType").val(searchType).prop("selected", true);
			            if(myBoardIdx == null || myBoardIdx == "" || 
					            typeof myBoardIdx == "undefined" ){
							 $("#myBoardId").prop("checked", false);
						 } else {
							 $("#myBoardId").prop("checked", true);
						 }
			        }
			}); 
		});

		<%-- 정렬 --%>
		$(document).on( "click", "#orderBtn", function() {
			var $this = $(this);
			var data = $this.data("order");

			// page, perPage, search, searchType, order
			var page = $("#pageInfo").val();
			var perpage = $("#perPageInfo").val();
			var searchVal = $("#searchVal").val();
			var searchType =  $("#searchTypeVal").val();

			var orderVal = $("#orderVal").val();

			var myBoardIdx = $("#tempIdx").val();

			// 정렬값
			var order = "";

			if(data == 'R') {
				
				if(orderVal == "RA") {
					order = "RD";
				} else {
					order = "RA";
				}
				
			} else if(data == 'U') {

				if(orderVal == "UA") {
					order = "UD";
				} else {
					order = "UA";
				}
			
			} else if(data == 'V') {

				if(orderVal == "VA") {
					order = "VD";
				} else {
					order = "VA";
				}
			}

			$.ajax({
				url : "/board/dynamic/boardlist/" + page,
				dataType : "html",
			    data : {
							perPageNum  : perpage,
							searchTitle : searchVal,
							searchType  : searchType,
							order 	    : order,
							myBoardIdx  : myBoardIdx
				    	},
			    error : function(e) {
					alert(e);	
				},
				success : function(data) {
				  $('.container-fluid').html(data);
		          $("#searchTitle").val(searchVal);
		          $("#searchType").val(searchType).prop("selected", true);
		          $("#perPageBtn").val(perpage).prop("selected", true);
		          
		          if(myBoardIdx == null || myBoardIdx == "" || typeof myBoardIdx == "undefined" ){
						 $("#myBoardId").prop("checked", false);
					 } else {
						 $("#myBoardId").prop("checked", true);
					 }
				}
			});
		});

		<%-- 업데이트 페이지 -> 상세 페이지 이동 --%>
		$(document).on("click", "#getPageBtn", function() {
			var page = $("#pageUpdateInfo").val();
			var perPage =  $("#updatePerPageNum").val();
		    var searchTitle = $("#updateSearchTitle").val();
			var searchType = $("#updateSearchType").val();
			var orderVal = $("#orderVal").val();
			var bno = $("#b_n").val();
			var myIdx = $("#myIdx").val();
			
			var info = {
					bno        : bno,
					page       : page,
					perPageNum : perPage,
					searchTitle: searchTitle,
					searchType : searchType,
					order      : orderVal,
					myBoardIdx : myIdx
				}

			$.ajax({
		        type : "GET",
		        url : "/board/dynamic/boardgetform",
		        dataType : "html",
		        data : info,
		        success : function(data) {
		        	$('.container-fluid').html(data);
		        },
		        error : function() {
		            alert('실패');
		        }
		  	});
		});
	});

	<%-- 유효성 체크 --%>
	function valicheck() {
		var b_id = new Array("t", "w", "c");
		
		var board_val = new Array();
		
		var bno =  $("#b_n").val();
		var category = $("#b_a").val();
		var searchTitle = $("#updateSearchTitle").val();
		var searchType = $("#updateSearchType").val();
		var perPage = $("#updatePerPageNum").val();
		var page = $("#pageUpdateInfo").val();
		var orderVal = $("#orderVal").val();
		var userid = $("#useridx").val();
		var myBoardIdx = $("#myIdx").val();

		// 특수문자 패턴
		var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi; 

		for( var i = 0; i < b_id.length; i++ ) {
			var tag = "";
			var key = b_id[i];

			// b_id 배열 변수의 값들로 제이쿼리 선택자를 만든다.
			tag = "#b_"+key;
			$tag = $(tag);

			// board_val에 그 선택자의 값을 넣어준다.
			if(b_id[i]) {
				board_val[i] = $tag.val().trim();
			}

			// 공백 체크(공통)
			if(board_val[i] == null || board_val[i] == "" || board_val[i].length <= 0 ) {
				if(i == 0 || i == 2) {
					alert($tag.prev().children().text() +"을 입력해주세요.");
				} else {
					alert($tag.prev().children().text() +"를 입력해주세요.");
				}
				$tag.focus();
				return;
			}
		}

		// 제목 유효성 체크
		if(board_val[0].length >= 60) {
			alert("제목은 60자 이상 불가능 합니다.");
			$("#b_t").focus();
			return;
		}

		// 작성자 유효성 체크
		if(special_pattern.test(board_val[1])) {
			alert("작성자는 특수문자가 불가능 합니다");
			$("#b_w").focus();
			return;
		}
		
		if(board_val[1].length >= 20) {
		  alert("작성자는 20자 이상 불가능 합니다.")
		  $("#b_w").focus();
		  return;
		}
		
		// 내용 유효성 체크
		if(board_val[2].length > 1000) {
			alert("1000자를 초과 하셨습니다.");
			return;
		}
		
		var board = {
			bno	        : bno,
			title       : board_val[0],
			writer      : board_val[1],
			content     : board_val[2],
			id          : userid,
			category    : category, 
			searchTitle : searchTitle,
			searchType  : searchType,
			perPageNum  : perPage,
			page        : page,
			order       : orderVal,
			myBoardIdx  : myBoardIdx
		};

		return function() {
			return board;
		}
	}

	
	<%-- 게시글 리스트 page 이동 --%>
	function boardList(pageIndex) {
		 var searchTitle =$("#searchVal").val();
		 var searchType = $("#searchTypeVal").val();
		 var perPage = $("#perPageInfo").val();
		 var orderVal = $("#orderVal").val();
		 var myBoardIdx = $("#tempIdx").val();

		 $.ajax({
		        type : "GET",
		        url : "/board/dynamic/boardlist/"+pageIndex,
		        dataType : "html",
		        data : {
			        	searchTitle : searchTitle,
			        	perPageNum  : perPage,
			        	searchType  : searchType, 
			        	order       : orderVal,
			        	myBoardIdx  : myBoardIdx
			           },
		        error : function() {
		            alert('실패');
		        },
		        success : function(data) {
		            $('.container-fluid').html(data);
		            $("#searchTitle").val(searchTitle);
		            
		            if(typeof searchType == "undefined" || searchType == null || searchType == "" ) {
		            	$("#searchTypeVal").val("T").prop("selected", true);
			        } else {
			        	$("#searchTypeVal").val(searchType).prop("selected", true);
					}

					// 첫 페이지 로드할경우 perPage input에 upndefined시 10으로 초기화
		            if(typeof perPage == "undefined") {
		            	$("#perPageBtn").val("10").prop("selected", true);
			        } else {
			        	$("#perPageBtn").val(perPage).prop("selected", true);
					}

		            if(myBoardIdx == null || myBoardIdx == "" || typeof myBoardIdx == "undefined" ){
						 $("#myBoardId").prop("checked", false);
					 } else {
						 $("#myBoardId").prop("checked", true);
					 }
		        }
		  });
	}

	<%-- 엔터와 클릭에 사용될 검색 공통 함수 --%>
	function commonSearch(type, perPage, search) {
		 $.ajax({
		        type : "GET",
		        url : "/board/dynamic/boardlist/"+1,
		        dataType : "html",
		        data : search,
		        error : function() {
		            alert('실패');
		        },
		        success : function(data) {
		            $('.container-fluid').html(data);
		            $("#searchTitle").val(search.searchTitle);
		            $("#searchInput").focus();
		            $("#perPageBtn").val(perPage).prop("selected", true);
		            $("#searchType").val(type).prop("selected", true);

		            if(search.myBoardIdx == null || search.myBoardIdx == "" || 
				            typeof search.myBoardIdx == "undefined" ){
						 $("#myBoardId").prop("checked", false);
					 } else {
						 $("#myBoardId").prop("checked", true);
					 }
		        }
		  });
	}
	
</script>

<%@ include file="../include/header.jsp" %>
 		<div class="container-fluid"></div>
 	</div>
<%@ include file="../include/footer.jsp" %>
</body>
</html>