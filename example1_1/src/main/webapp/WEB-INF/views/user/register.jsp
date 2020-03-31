<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  <title>SB Admin 2 - Register</title>
  <!-- Custom fonts for this template-->
  <link href="../../../resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../../../resources/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-primary">

  <div class="container">

    <div class="card o-hidden border-0 shadow-lg my-5">
      <div class="card-body p-0">
        <!-- Nested Row within Card Body -->
        <div class="row">
          <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
          <div class="col-lg-7">
            <div class="p-5">
              <div class="text-center">
                <h1 class="h4 text-gray-900 mb-4">회원가입</h1>
              </div>
              <form class="userForm" action="/user/register" method="post">
                <div class="form-group">
                  <input type="email" class="form-control form-control-user" id="exampleInputEmail" name="email" placeholder="이메일 주소">
                </div>
                <div id="duplicateInfo" style="color: red; font-size: 12px; margin-left: 10px; margin-bottom: 5px;"></div>
                <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="password" class="form-control form-control-user" id="exampleInputPassword" name="password"  placeholder="비밀번호">
                  </div>
                  <div class="col-sm-6">
                    <input type="password" class="form-control form-control-user" id="exampleRepeatPassword" placeholder="비밀번호 확인">
                  </div>
                </div>
                  <div style="color: red; font-size: 12px; margin-left: 10px; margin-bottom: 5px;"></div>
                <div id="passwordCheckInfo" style="color:black; font-size: 10px; margin-left: 10px; margin-bottom: 10px;">비밀번호는 8 ~ 10자 영문, 숫자를 사용하세요</div>
                  <div class="form-group row">
                  <div class="col-sm-6 mb-3 mb-sm-0">
                    <input type="text" class="form-control form-control-user" name="name" id="exampleName" name="name" placeholder="이름">
                  </div>
                  </div>
                  
                <button id="regBtn" type="submit" style="font-size: 20px;" class="btn btn-primary btn-user btn-block">
                  회원가입
                </button>
                 <a id="" href="/loginform" style="font-size: 20px;" class="btn btn-danger btn-user btn-block">
                  취소
                </a>
                <hr style="height: 100px;">
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script type="text/javascript">
	$(document).ready(function() {
		$("#exampleInputEmail").focus();
		
		var emailRegEXP = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; // email 형식
		var passwordRegExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,10}$/; // 8 ~ 10자 영문, 숫자 조합
		var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi; 
		var $exampleInputEmail = $("#exampleInputEmail");
		var $exampleInputPassword = $("#exampleInputPassword");
		var $exampleRepeatPassword = $("#exampleRepeatPassword");
		var $exampleName = $("#exampleName");
		var $passwordCheckInfo = $("#passwordCheckInfo");
		var dupliCheck= false; // 이메일 중복 최종 확인
		var passwordCheck = false; // 비밀번호 확인
		// 이메일 체크
		$exampleInputEmail.on("keyup",function() {
			var emailValue = {email : $(this).val()};

			$.ajax({
				url : "/user/emailCheck",
				type :"POST",
				data : emailValue,
				error : function() {
					alert("실패");
				},
				success : function(result) {
					
					 if(result.duplicate == 1) {
						$("#duplicateInfo").text("이미 사용중인 이메일 입니다.");
						dupliCheck = true;
	  				 } else {
	  					$("#duplicateInfo").text("");
	  					dupliCheck = false;
	  	  			}
				}
			})
		})
		
		// 비밀번호 체크 
		$exampleRepeatPassword.on("keyup",function() {
			var passwordVal = $(this).val();
			if(passwordVal == $exampleInputPassword.val()) {
				$passwordCheckInfo.text("");
				 passwordCheck = false;
			} else {
				$passwordCheckInfo.text("비밀번호가 일치하지 않습니다.");
				passwordCheck = true;
			}
		})
		
		// 가입버튼
		$("#regBtn").on("click", function(e) {
			e.preventDefault();
			var emailValue = $exampleInputEmail.val().trim();
			var passwordValue = $exampleInputPassword.val().trim();
			var passwordRepeat = $exampleRepeatPassword.val().trim();
			var nameValue= $exampleName.val().trim();
			var arrValue = new Array(emailValue, passwordValue, passwordRepeat, nameValue);
			var arrSelect = new Array()

			if(!emailRegEXP.test(emailValue)) {
				alert("이메일을 확인해주세요.");
				$exampleInputEmail.focus();
				return;
			}
			
			if(dupliCheck) {
				alert("이메일을 확인해 주세요.");
				$exampleInputEmail.focus();
				return;
			}

			if(!passwordRegExp.test(passwordValue)) {
				alert("8 ~ 10자 영문, 숫자를 사용하세요");
				$exampleInputPassword.focus();
				return;
			}

			if(passwordCheck == true) {
				alert("비밀번호를 확인해주세요.");
				$exampleRepeatPassword.focus();
				return;
			}

			if(nameValue == 1 || nameValue >= 10){
				alert("이름은 1자 또는 10자이상 불가능합니다.");
				$exampleName.focus();
				return;
			}

			for(var i = 0; i < arrValue.length; i++ ) {
				// var blank_pattern=/[\s]/g;
				
				if(arrValue[i] == null || arrValue[i].length < 1 || arrValue[i] == "" ) {
					if(i == 0) {
						alert("이메일을 입력해주세요.");
						$exampleInputEmail.val("");
						$exampleInputEmail.focus();
					} else if(i == 1) {
						alert("비밀번호를 입력해주세요.");
						$exampleInputPassword.val("");
						$exampleInputPassword.focus();
					} else if(i == 2) {
						alert("비밀번호를 입력해주세요.");
						$exampleRepeatPassword.val("");
						$exampleRepeatPassword.focus();
					} else if(i == 3) {
						alert("이름을 입력해주세요.");
						$exampleName.focus();
					}
					return;
				}
			}

			alert("회원가입이 완료되었습니다.");
			$(".userForm").submit();

		})
			
	})
  // chamym@naver.com
  </script>

  <!-- Bootstrap core JavaScript-->
  <script src="../../../resources/vendor/jquery/jquery.min.js"></script>
  <script src="../../../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="../../../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="../../../resources/js/sb-admin-2.min.js"></script>

</body>

</html>
