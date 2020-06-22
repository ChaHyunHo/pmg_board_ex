<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	.fileDrop {
		width: 100%;
		height: 200px;
		border: 1px dotted blue;
	}
	
	small {
		margin-left: 3px;
		font-weight: bold;
		color: gray; 
	}
</style>
<meta http-equiv="Content-type" content="text/html; charset=UTF-8">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="font-size: 20px; margin-bottom: 13px;">Ajax 파일 업로드</div>
	
	<div class="fileDrop"></div>
	
	<div class="uploadList"></div>
	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".fileDrop").on("dragenter dragover", function(e) {
			e.preventDefault();
			
		});
		$(".fileDrop").on("drop", function(e) {
			e.preventDefault();

			var files = e.originalEvent.dataTransfer.files;

			var file = files[0];

			console.log(file);

			var formData = new FormData();

			formData.append("file", file);

			$.ajax({
				url : '/ajaxUpload',
				data : formData,
				dataType : 'text',
				processData : false,
				contentType : false,
				type : 'POST',
				success : function(result) {
					alert(result);	
				}
			});
		});
	})
</script>
</body>
</html>