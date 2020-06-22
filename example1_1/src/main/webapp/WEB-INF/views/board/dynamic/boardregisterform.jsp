<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div class="page-header">
	<h4 class="page-title" style="margin-top: 20px;">게시판</h4>
	<ol class="breadcrumb">
		<li class="breadcrumb-item">Pages</li>
		<li class="breadcrumb-item active" aria-current="page">게시글 등록</li>
	</ol>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="row">
				<div class="col-lg-12">
					<div class="expanel">
						<form id="regFrm" name="regFrm" accept-charset="multipart/form-data" onsubmit="return false">
							<input type="hidden" id="userid" name="id" value="${idx}" />
							<!-- 패널 헤딩 끝  -->
							<div class="card">
								<div class="input-group">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-default" style="padding-left: 10px;"><span style="font-size: 13px;">카테고리</span> </span>
									</div>
									<select id="b_a" name="category" aria-controls="dataTable" style="width: 10px; height: 38px;"
										class="custom-select-sm form-control form-control-sm">
										<option value="MEM" selected="selected">일반 게시글</option>
										<option value="ADMIN">공지사항</option>
									</select>
								</div>
								<div id="adminPassword"></div>
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="inputGroup-sizing-default" style="padding-left: 30px;">제목</span>
								</div>
								<input type="text" id="b_t" class="form-control"  name="title" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default">
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="inputGroup-sizing-default">작성자</span>
								</div>
								<sec:authentication var="principal" property="principal" />
								<input type="text" id="b_w" name="writer" class="form-control"  value="<c:out value='${userName}' />" disabled="disabled">
							</div>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text" style="padding-left: 30px;">내용</span>
								</div>
								<textarea class="form-control" id="b_c" name="content" aria-label="With textarea" rows="11" maxlength="1000"></textarea>
							</div>
							<div style="margin-left: 75px; font-size: 18px;">
								<span id="contentLen">0</span>/1000
							</div>
							<div class="input-group">
								<div class="input-group-prepend ">
									<span class="input-group-text" style="padding-left: 2px;">파일첨부</span>
								</div>
								<div class="dynamicFileForm">
									<div style="margin-top: 8px; margin-left: 10px;">
										<input type="file" name="file" id="file" />
										<button type="submit" class="btn btn-outline-danger" id="fileDelBtn" style="margin-top: 5px;">삭제</button>
									</div>
								</div>
							</div>
						</form>
						<div>
							<sec:authentication var="principal" property="principal" />
							<sec:authorize access="isAuthenticated()">
								<button type="submit" class="btn btn-outline-primary" id="boardRegBtn" style="margin-top: 5px;">등록</button>
							</sec:authorize>
							<button type="reset" class="btn btn-outline-primary" id="registerListGo" style="margin-top: 5px;">목록</button>
						</div>
						<input type="hidden" id="useridx" value="<c:out value='${idx}'/>" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
