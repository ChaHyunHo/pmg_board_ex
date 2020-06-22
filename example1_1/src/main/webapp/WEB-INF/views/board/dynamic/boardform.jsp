<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>


<h1 class="h3 mb-2 text-gray-800" style="margin-top: 20px;">게시판</h1>
<p class="mb-4">dynamic board</p>
<jsp:include page="/WEB-INF/views/include/loginfo.jsp"></jsp:include>

<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">Board List</h6>

	</div>
	<div class="card-body" style="padding-bottom: 10px;">
		<div>
			<div style="float: left; margin-bottom: 10px;">
				<button type="button" class="btn btn-outline-primary" id="boardRegMove">등록</button>
				<!-- Single button -->
				<div class="btn-group">
					<div style="margin-top: 5px; margin-right: 3px; margin-left: 4px;">
						<b>show:</b>
					</div>
					<select id="perPageBtn" name="dataTable_length" style="height: 38px;" class="custom-select custom-select-sm form-control form-control-sm">
						<option value="5">5개씩</option>
						<option value="10">10개씩</option>
						<option value="15">15개씩</option>
						<option value="20">20개씩</option>
						<option value="25">25개씩</option>
					</select>
				</div>
			</div>
		</div>
		<div style="float: right; margin-bottom: 10px;">
			<div class="input-group">
				<div class="custom-control custom-checkbox small" style="margin-right: 20px; margin-top: 10px;">
					<input type="checkbox" class="custom-control-input" id="myBoardId" value=""> <label class="custom-control-label" for="myBoardId">내글보기</label>
				</div>
				<select id="searchType" name="searchType" aria-controls="dataTable" style="width: 10px; height: 38px;"
					class="custom-select-sm form-control form-control-sm">
					<option value="T">제목</option>
					<option value="W">작성자</option>
					<option value="TC">제목+내용</option>
				</select> <input type="text" class="form-control" placeholder="Search..." id="searchTitle" autocomplete="new-password">
				<div class="input-group-append">
					<button class="btn btn-primary" type="button" id="searchBtn">
						<i class="fa fa-search"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
	<div class="table">
		<table class="table" id="dataTable" width="100%" cellspacing="0">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th id="thOrder"><a data-order="R" id="orderBtn" href="javascript:void(0);" style="color: #858796; text-decoration: none;"> 작성일 <c:if
								test="${orderVal eq 'RA'}">
								<i class="fas fa-long-arrow-alt-up" id="r_up" style="margin-left: 5px; color: orange;"></i>
							</c:if> <c:if test="${orderVal ne 'RA'}">
								<i class="fas fa-long-arrow-alt-up" id="r_up" style="margin-left: 5px;"></i>
							</c:if> <c:if test="${orderVal eq 'RD'}">
								<i class="fas fa-long-arrow-alt-down" id="r_down" style="color: orange;"></i>
							</c:if> <c:if test="${orderVal ne 'RD'}">
								<i class="fas fa-long-arrow-alt-down" id="r_down"></i>
							</c:if>
					</a></th>
					<th id="thOrder"><a data-order="U" id="orderBtn" href="javascript:void(0);" style="color: #858796; text-decoration: none;"> 수정일 <c:if
								test="${orderVal eq 'UA'}">
								<i class="fas fa-long-arrow-alt-up" id="r_up" style="margin-left: 5px; color: orange;"></i>
							</c:if> <c:if test="${orderVal ne 'UA'}">
								<i class="fas fa-long-arrow-alt-up" id="r_up" style="margin-left: 5px;"></i>
							</c:if> <c:if test="${orderVal eq 'UD'}">
								<i class="fas fa-long-arrow-alt-down" id="r_down" style="color: orange;"></i>
							</c:if> <c:if test="${orderVal ne 'UD'}">
								<i class="fas fa-long-arrow-alt-down" id="r_down"></i>
							</c:if>
					</a></th>
					<th id="thOrder"><a data-order="V" id="orderBtn" href="javascript:void(0);" style="color: #858796; text-decoration: none;"> 조회수 <c:if
								test="${orderVal eq 'VA'}">
								<i class="fas fa-long-arrow-alt-up" id="r_up" style="margin-left: 5px; color: orange;"></i>
							</c:if> <c:if test="${orderVal ne 'VA'}">
								<i class="fas fa-long-arrow-alt-up" id="r_up" style="margin-left: 5px;"></i>
							</c:if> <c:if test="${orderVal eq 'VD'}">
								<i class="fas fa-long-arrow-alt-down" id="r_down" style="color: orange;"></i>
							</c:if> <c:if test="${orderVal ne 'VD'}">
								<i class="fas fa-long-arrow-alt-down" id="r_down"></i>
							</c:if>
					</a></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${noticeList}" var="notice">
					<c:if test="${pageDTO.pagevo.page eq '1'}">
						<c:if test="${empty searchTitle}">
							<tr id="board_tr" style="font-weight: 800;">
								<td data-bno="${notice.bno}" style="width: 80px; padding-left: 17px;"><span class="badge badge-pill badge-warning">공지</span></td>
								<td style="width: 500px;"><a href="javascript:void(0);" id="board_title" style="color: #858796;"><c:out value="${notice.title}"
											escapeXml="false" /></a></td>
								<td style="width: 100px;"><c:out value="${notice.writer}" escapeXml="false" /></td>
								<td style="width: 200px;"><fmt:formatDate value="${notice.registerDate}" pattern="yyyy-MM-dd hh:mm" /></td>
								<td style="width: 200px;"><fmt:formatDate value="${notice.updateDate}" pattern="yyyy-MM-dd hh:mm" /></td>
								<td style="width: 100px; padding-left: 20px;"><span class="badge badge-pill badge-light"><c:out value="${notice.viewCount}"
											escapeXml="false" /></span></td>
							</tr>
						</c:if>
					</c:if>
				</c:forEach>

				<c:forEach items="${boardList}" var="list">
					<tr id="board_tr">
						<td style="width: 80px; padding-left: 17px;"><c:out value="${list.newcount}" /></td>
						<td style="width: 500px;"><a href="javascript:void(0);" id="board_title" style="color: #858796;"> <c:out value="${list.title}"
									escapeXml="false" /></a> <c:if test="${list.newLabel}">
								<span class="badge badge-danger" style="font-size: 10px;">N</span>
							</c:if></td>
						<td style="width: 100px;"><c:out value="${list.writer}" escapeXml="false" /></td>
						<td style="width: 200px;"><fmt:formatDate value="${list.registerDate}" pattern="yyyy-MM-dd hh:mm" /></td>
						<td style="width: 200px;"><fmt:formatDate value="${list.updateDate}" pattern="yyyy-MM-dd hh:mm" /></td>
						<td style="width: 100px; padding-left: 20px;"><span class="badge badge-pill badge-light"><c:out value="${list.viewCount}"
									escapeXml="false" /></span></td>
					</tr>
					<input type="hidden" value="<c:out value='${list.bno }' />" />
				</c:forEach>
			</tbody>
		</table>
		<c:if test="${empty boardList}">
			<div style="text-align: center; margin-top: 30px; margin-right: 20px;">게시글이 존재하지 않습니다.</div>
		</c:if>
		<c:if test="${!empty boardList}">
			<div style="text-align: center;">
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center pagination-sm custompagination">
						<c:if test="${pageDTO.prev}">
							<li class="page-item"><a class="page-link" href="javascript:void(0);" aria-label="Previous" id="prevBtn"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>

						<c:forEach begin="${pageDTO.startPage}" end="${pageDTO.endPage}" var="index">
							<c:if test="${pageDTO.endPage ne 1}">
								<li class="page-item <c:out value="${pageDTO.pagevo.page == index?'active' : '' }"/>"><a class="page-link" href="javascript:void(0);"
									id="pageIndex">${index}</a></li>
							</c:if>
						</c:forEach>

						<c:if test="${pageDTO.next && pageDTO.endPage > 0}">
							<li class="page-item"><a class="page-link" href="javascript:void(0);" aria-label="Previous" id="nextBtn"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
					</ul>
				</nav>
			</div>
		</c:if>
	</div>
</div>

<form id="listForm">
  	<input type="hidden" name="page"        id="pageInfo"      value="<c:out value='${pageDTO.pagevo.page}' />" />
    <input type="hidden" name="perPageNum"  id="perPageInfo"   value="<c:out value='${pageDTO.pagevo.perPageNum}' />" />
    <input type="hidden" name="realEnd"     id="pageEnd"       value="<c:out value='${pageDTO.endPage}' />" />
    <input type="hidden" name="next"        id="pageNext"      value="<c:out value='${pageDTO.next}' />" />
    <input type="hidden" name="startPage"   id="pageStart"     value="<c:out value='${pageDTO.startPage}' />" />
    <input type="hidden" name="searchTitle" id="searchVal"     value="<c:out value='${searchTitle}' />" />
    <input type="hidden" name="searchType"  id="searchTypeVal" value="<c:out value='${searchType}' />" />
    <input type="hidden" name="order"       id="orderVal"      value="<c:out value='${orderVal}' />" />
    <input type="hidden" name="myBoardIdx"  id="myIdx"         value="<c:out value='${idx}' />" />
    <input type="hidden" name="tempIdx"     id="tempIdx"       value="<c:out value='${tempIdx}' />" />
</form>
