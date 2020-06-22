/**
 * ajax를 이용해 화면에 동적으로 생성해 준다.
 */

var ajaxJsonCommon = function(url, data, callback, bno) {
	var objData = {};
	if(data != null) {
		if($(data).prop('tagName') == "FORM") {
			objData = $(data).serialize(); // serializeObject(data, dataObj);
		} else {
			objData = data;
		}
	}
	
	// 게시글 조회시 특정 bno 추가
	if(bno != null) {
		objData = objData + "&bno="+ bno;
	}
	
	$.ajax({
        type : "POST",
        url : url,
        dataType : "html",
        beforeSend : function(jqXHR){
	    	var token  = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			jqXHR.setRequestHeader(header, token);
	    },
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
	    headers: {'X-Ajax-Error-Accept': 'application/json'},
        data : objData,
        success : function(data) {
        	if(callback) {
        			callback(data);
        		
        	}
        },
        error : function() {
            alert('실패');
        }
  	});
}
