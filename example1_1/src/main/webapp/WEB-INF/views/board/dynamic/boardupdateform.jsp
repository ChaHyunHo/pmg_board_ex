<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="page-header">
	<h4 class="page-title" style="margin-top: 20px;">게시판</h4>
	<ol class="breadcrumb">
		<li class="breadcrumb-item">Pages</li>
		<li class="breadcrumb-item active" aria-current="page">게시글 수정</li>
	</ol>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="row">
				<div class="col-lg-12">
					<div class="expanel">
						<div class="card">
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="inputGroup-sizing-default" style="padding-left: 30px;">제목</span>
								</div>
								<input type="text" id="b_t" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"
									value="<c:out value='${board.title}' escapeXml="false" />" />
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="inputGroup-sizing-default">작성자</span>
								</div>
								<input type="text" id="b_w" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"
									value="<c:out value='${board.writer}' escapeXml="false" />" disabled="disabled" />
							</div>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text" style="padding-left: 30px;">내용</span>
								</div>
								<textarea class="form-control" id="b_c" aria-label="With textarea" rows="13"><c:out value='${board.content}' escapeXml="false" /></textarea>
							</div>
							<div style="margin-left: 75px; font-size: 18px;">
								<span id="contentLen">0</span>/1000
							</div>
							<input type="hidden" id="b_n" value="<c:out value='${board.bno}'/>" />
							<div>
								<sec:authentication var="principal" property="principal" />
								<sec:authorize access="isAuthenticated()">
									<c:if test="${idx eq board.id || sessionAuth eq 'ROLE_ADMIN' }">
										<button type="submit" class="btn btn-outline-primary" id="boardUpRegBtn" style="margin-top: 5px;">수정</button>
									</c:if>
								</sec:authorize>
								<button type="button" class="btn btn-outline-primary" id="getPageBtn" style="margin-top: 5px;">취소</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<form id ="updateForm">
	<input type="hidden" name="page"         id="pageUpdateInfo"    value="<c:out value='${page}' />" />
	<input type="hidden" name="searchTitle"  id="updateSearchTitle" value="<c:out value='${searchTitle}' />" />
	<input type="hidden" name="searchType"   id="updateSearchType"  value="<c:out value='${searchType}' />" />
	<input type="hidden" name="perPageNum"   id="updatePerPageNum"  value="<c:out value='${search.perPageNum}' />" />
	<input type="hidden" name="order"        id="orderVal"          value="<c:out value='${orderVal}' />" />
	<input type="hidden" name="myBoardIdx"   id="myIdx"             value="<c:out value='${search.myBoardIdx}' />" />
</form>
