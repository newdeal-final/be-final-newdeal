<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}" />
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.4/components/registrations/registration-12/assets/css/registration-12.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/css/style.css">
</head>
<style>


</style>
<script>
    // Validator 객체 정의 - 유효성 검사용
    const Validator = {
        isValid: true,
        //비밀번호 유효성 검사
        validatePassword: function() {
            const password = document.getElementById("password").value;
            const passwordCheck = document.getElementById("passwordCheck").value;
            const passwdCheckWarn = document.getElementById("passwdCheckWarn");
            const passwordPattern = /^(?=.*[!@#$])[A-Za-z\d!@#$]{8,16}$/;

            if (!passwordPattern.test(password)) {
                passwdCheckWarn.innerText = "비밀번호는 8자 이상 16자 이하이고, 특수문자(!@#$)를 포함해야 합니다.";
                passwdCheckWarn.style.color = "red";
                this.isValid = false;
            } else if (password !== passwordCheck) {
                passwdCheckWarn.innerText = "비밀번호가 일치하지 않습니다.";
                passwdCheckWarn.style.color = "red";
                this.isValid = false;
            } else {
                passwdCheckWarn.innerText = "비밀번호가 일치합니다.";
                passwdCheckWarn.style.color = "green";
                this.isValid = true;
            }
            return this.isValid;
        },
        //핸드폰 유효성 검사
        validatePhone: function() {
            const phone = document.getElementById("phone").value;
            const phoneCheckWarn = document.getElementById("phoneCheckWarn");
            const phonePattern = /^0\d{10}$/;

            if (!phonePattern.test(phone)) {
                phoneCheckWarn.innerText = "핸드폰 번호를 정확히 입력해 주세요.";
                phoneCheckWarn.style.color = "red";
                this.isValid = false;
            } else {
                phoneCheckWarn.innerText = "";
                this.isValid = true;
            }
            return this.isValid;
        },
        // 폼 유효성 검사
        validateForm: function() {
            this.isValid = true; // 초기화

            const isPasswordValid = this.validatePassword();
            const isPhoneValid = this.validatePhone();
            if (!isPasswordValid || !isPhoneValid) {
                alert("회원정보를 정확하게 입력해주세요.");
                return false;
            }
            return true;
        }
    };

    $(document).ready(function() {
        // 입력 필드에 이벤트 리스너 추가
        $("#passwordCheck").on("input", function() {
            Validator.validatePassword();
        });
        $("#password").on("input", function() {
            Validator.validatePassword();
        });
        $("#phone").on("input", function() {
            Validator.validatePhone();
        });

        // 제출 전 유효성 검사
        $("form").submit(function(event) {
            if (!Validator.validateForm()) {
                //컨트롤러에서 예외처리 메시지 전송
                alert(${message});
                event.preventDefault(); // 폼 제출을 막음
            }
        });
    });
    function checkDuplicateEmail() {
        const email = document.getElementById("email").value;
        const emailCheckWarn = document.getElementById("emailCheckWarn");

        $.ajax({
            url: '/member/duplicateEmail',
            type: 'POST',
            data: { email: email },
            success: function(response) {
               emailCheckWarn.innerText = response;
               emailCheckWarn.style.color = "green";
            },
            error: function(error) {
               emailCheckWarn.innerText = error;
               emailCheckWarn.style.color = "red";
            }
        });
    }
</script>
<body>
<!-- 회원가입 -->
    <section class="py-3 py-md-5 py-xl-8">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="mb-5" align="center">
                        <img src="${contextPath}/images/logo.png" alt="로고" width="250" onclick="location.href='${contextPath}/'">
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-12 col-lg-10 col-xl-8">
                    <div class="row gy-5 justify-content-center">
                        <div class="col-12 col-lg-5">
                            <!--폼 시작-->
                            <form action="${contextPath}/member/register" method="post">
                                <div class="row gy-3 overflow-hidden">
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control border-0 border-bottom rounded-0" name="name" id="name" placeholder="name" required>
                                            <label for="name" class="form-label-ysh">성명</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="text" class="form-control border-0 border-bottom rounded-0" name="phone" id="phone" placeholder="휴대폰 번호" maxlength="11" required onchange="validatePhone();">
                                            <label for="phone" class="form-label-ysh">휴대폰 번호</label>
                                            <div id="phoneCheckWarn" class="error-message-ysh"></div>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="email" class="form-control border-0 border-bottom rounded-0" name="email" id="email" placeholder="이메일 주소" required onkeyup="checkDuplicateEmail();" >
                                            <label for="email" class="form-label-ysh">이메일</label>
                                            <div id="emailCheckWarn" class="error-message-ysh"></div>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="password" class="form-control border-0 border-bottom rounded-0" name="password" id="password" value="" placeholder="Password" required maxlength="16">
                                            <label for="password" class="form-label-ysh">비밀번호</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-floating mb-3">
                                            <input type="password" class="form-control border-0 border-bottom rounded-0" name="passwordCheck" id="passwordCheck" value="" placeholder="Password" required maxlength="16" onchange="validatePassword();">
                                            <label for="passwordCheck" class="form-label-ysh">비밀번호 확인</label>
                                            <div id="passwdCheckWarn" class="error-message-ysh"></div>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" value="" name="iAgree" id="iAgree" required>
                                            <label class="form-check-label text-secondary" for="iAgree">
                                                전체동의 <a href="#!" class="link-primary text-decoration-none">이용약관</a>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="d-grid">
                                            <button class="btn btn-lg btn-dark rounded-0 fs-6"  style="color: white; background-color: #0D31B2" type="submit">회원가입</button>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="d-grid">
                                            <p class="text-center m-0">Already have an account? <a href="${contextPath}/member/login-page" class="link-primary text-decoration-none">로그인</a></p>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="col-12 col-lg-2 d-flex align-items-center justify-content-center gap-3 flex-lg-column">
                            <div class="bg-dark h-100 d-none d-lg-block" style="width: 1px; --bs-bg-opacity: .1;"></div>
                            <div class="bg-dark w-100 d-lg-none" style="height: 1px; --bs-bg-opacity: .1;"></div>
                            <div>or</div>
                            <div class="bg-dark h-100 d-none d-lg-block" style="width: 1px; --bs-bg-opacity: .1;"></div>
                            <div class="bg-dark w-100 d-lg-none" style="height: 1px; --bs-bg-opacity: .1;"></div>
                        </div>
                        <div class="col-12 col-lg-5 d-flex align-items-center">
                            <div class="d-flex gap-3 flex-column w-100 ">
                                <a href="#!" class="btn bsb-btn-2xl btn-outline-dark rounded-0 d-flex align-items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-google text-danger" viewBox="0 0 16 16">
                                        <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z" />
                                    </svg>
                                    <span class="ms-2 fs-6 flex-grow-1">다음 로그인</span>
                                </a>
                                <a href="${contextPath}/oauth2/authorization/naver" class="btn bsb-btn-2xl btn-outline-dark rounded-0 d-flex align-items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-apple text-dark" viewBox="0 0 16 16">
                                        <path d="M11.182.008C11.148-.03 9.923.023 8.857 1.18c-1.066 1.156-.902 2.482-.878 2.516.024.034 1.52.087 2.475-1.258.955-1.345.762-2.391.728-2.43Zm3.314 11.733c-.048-.096-2.325-1.234-2.113-3.422.212-2.189 1.675-2.789 1.698-2.854.023-.065-.597-.79-1.254-1.157a3.692 3.692 0 0 0-1.563-.434c-.108-.003-.483-.095-1.254.116-.508.139-1.653.589-1.968.607-.316.018-1.256-.522-2.267-.665-.647-.125-1.333.131-1.824.328-.49.196-1.422.754-2.074 2.237-.652 1.482-.311 3.83-.067 4.56.244.729.625 1.924 1.273 2.796.576.984 1.34 1.667 1.659 1.899.319.232 1.219.386 1.843.067.502-.308 1.408-.485 1.766-.472.357.013 1.061.154 1.782.539.571.197 1.111.115 1.652-.105.541-.221 1.324-1.059 2.238-2.758.347-.79.505-1.217.473-1.282Z" />
                                        <path d="M11.182.008C11.148-.03 9.923.023 8.857 1.18c-1.066 1.156-.902 2.482-.878 2.516.024.034 1.52.087 2.475-1.258.955-1.345.762-2.391.728-2.43Zm3.314 11.733c-.048-.096-2.325-1.234-2.113-3.422.212-2.189 1.675-2.789 1.698-2.854.023-.065-.597-.79-1.254-1.157a3.692 3.692 0 0 0-1.563-.434c-.108-.003-.483-.095-1.254.116-.508.139-1.653.589-1.968.607-.316.018-1.256-.522-2.267-.665-.647-.125-1.333.131-1.824.328-.49.196-1.422.754-2.074 2.237-.652 1.482-.311 3.83-.067 4.56.244.729.625 1.924 1.273 2.796.576.984 1.34 1.667 1.659 1.899.319.232 1.219.386 1.843.067.502-.308 1.408-.485 1.766-.472.357.013 1.061.154 1.782.539.571.197 1.111.115 1.652-.105.541-.221 1.324-1.059 2.238-2.758.347-.79.505-1.217.473-1.282Z" />
                                    </svg>
                                    <span class="ms-2 fs-6 flex-grow-1" >네이버 로그인</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
