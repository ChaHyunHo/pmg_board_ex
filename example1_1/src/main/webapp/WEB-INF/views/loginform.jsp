<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin 2 - Login</title>

  <!-- Custom fonts for this template-->
  <link href="../../resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="../../resources/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-primary">
  <div class="container container-login">
  	 <div class="row justify-content-center">

      <div class="col-xl-10 col-lg-12 col-md-9">

        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <!-- Nested Row within Card Body -->
            <div class="row">
              <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
              <div class="col-lg-6">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">환영합니다!</h1>
                  </div>
                  <form id="loginForm" action="/loginform" method="post">
						<div class="form-group">
							<input type="text" class="form-control form-control-user" id="username" name="username" autocomplete="off"
								placeholder="이메일">
						</div>
						<div class="form-group">
							<input type="password" class="form-control form-control-user" id="password" name="password" autocomplete="off"  placeholder="비밀번호">
						</div>
						<div id="loginCheck" style="color: red; font-size: 12px;  margin-bottom: 5px;"></div>
					<!-- 	<div class="form-group">
							<div class="custom-control custom-checkbox small">
								<input type="checkbox" class="custom-control-input" id="customCheck" name='remember-me'> <label class="custom-control-label" for="customCheck">Remember Me</label>
							</div>
						</div> -->
						<button id="loginBtn" type="submit" style="font-size: 20px;"
							class="btn btn-primary btn-user btn-block">로그인</button>
				  </form>
                   <hr>
                   <div class="text-center">
                    <a class="small" href="/user/register">회원가입</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script type="text/javascript">

  var login = {
			$inputId : null,
			$inputPassword : null,
			$loginBtn : null,
			$loginCheck : null,
			$loginForm : null,
			error : null,
			username : null,

			init : function() {
				this.$inputId = $("#username");
				this.$inputPassword = $("#password");
				this.$loginBtn = $("#loginBtn");
				this.$loginCheck = $("#loginCheck");
				this.$loginForm = $("#loginForm");
				this.error = "<c:out value='${ERRORMSG}'/>"; // 에러 객체
				this.username = "<c:out value='${username}'/>"; // 에러 객체에서 받아온 아이디값
			},

			exeFn : function() {
				this.$inputId.val('');
				this.$inputPassword.val('');
				this.$inputId.focus();
			},

			errorCheckFn : function() {
				if(this.error) {
					this.$loginCheck.text(this.error);
					this.$inputId.val(this.username);
				} else {
					this.$loginCheck.text("");
				}

			},

			submitFn : function() {
				var objThis = this;
				objThis.$loginBtn.on("click", function(e) {
					e.preventDefault();
					var idValue = objThis.$inputId.val().trim();
					var passwordValue = objThis.$inputPassword.val().trim();

					var arrValue = new Array(idValue, passwordValue);

					for(var i = 0; i < arrValue.length; i++ ) {
						console.log(arrValue[i]);
						if(arrValue[i] == "" || arrValue[i] == null || arrValue[i].length <= 0 ) {
							if(i == 0) {
								alert("아이디를 입력해주세요.");
								objThis.$inputId.focus();
								return false;
							} else if(i == 1) {
								alert("비밀번호를 입력해주세요.");
								objThis.$inputPassword.focus();
								return false;
							}
						}
					}

					objThis.$loginForm.append("<input type='hidden' name='${_csrf.parameterName}' value='${_csrf.token}' />");
					
					objThis.$loginForm.submit();
				});
			}
		}
		 	
	$(document).ready(function() {
		login.init(); 
		login.exeFn(); // 포커스 , 값 초기화
		login.errorCheckFn(); // 공백 체크 및 로인 에러 객체
		login.submitFn(); // submit
	})
	
	

  </script>

  <!-- Bootstrap core JavaScript-->
  <script src="../../resources/vendor/jquery/jquery.min.js"></script>
  <script src="../../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="../../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="../../resources/js/sb-admin-2.min.js"></script>
  
  </div>
  
  
