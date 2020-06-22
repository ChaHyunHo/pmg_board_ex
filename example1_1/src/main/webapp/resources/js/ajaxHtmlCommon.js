/**
 * ajax를 이용해 화면에 동적으로 생성해 준다.
 */

var ajaxHtmlCommon = function(url,callback, bno) {

	
	$.ajax({
        type : "POST",
        url : url,
        dataType : "html",
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
