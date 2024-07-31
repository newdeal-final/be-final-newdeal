<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>로그인</title>
    <!-- Jquery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://unpkg.com/bs-brain@2.0.4/components/logins/login-12/assets/css/login-12.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/js-cookie/3.0.1/js.cookie.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${contextPath}/css/style.css">
    <link rel="stylesheet" href="${contextPath}/css/member.css">
    <script src="${contextPath}/js/member.js"></script>
</head>
<script>

$(document).ready(function() {
    sessionStorage.removeItem("token");
});

function loginBtn() {
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
    $.ajax({
        url: '/member/login',
        method: 'POST',
        data: {
            "email" : email,
            "password" : password,
            "role" : "ROLE_HOST"
        },
        success: function(data, status, xhr) {
            // 응답 헤더에서 JWT 토큰 읽기
            const token = xhr.getResponseHeader("Authorization");
            const role = "ROLE_HOST";
            console.log('role:', role);
            if (token) {
                sessionStorage.setItem("role", role);
                sessionStorage.setItem("token", token);
            }
            location.href="${contextPath}/hosts/"
        },
        error: function(error) {
            alert("아이디와 비밀번호를 확인해주세요.");
            console.error('로그인 실패:', error);
        }
    });
}
</script>
<body>
<!-- LoginController -->
<section class="py-3 py-md-5 py-xl-8">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="mb-5" align="center">
                    <img src="${contextPath}/images/logo.png" alt="로고" width="250"
                         onclick="location.href='${contextPath}/'">
                    <h1>호스트 로그인</h1>
                </div>
            </div>
        </div>
        <form action="${contextPath}/member/login" method="post" id="login-form">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-10 col-xl-8">
                <div class="row gy-5 justify-content-center">
                    <div class="col-12 col-lg-5">
                        <form action="#" method="post">
                            <div class="row gy-3 overflow-hidden">
                                <div class="col-12">
                                    <div class="form-floating mb-3">
                                        <input type="email" class="form-control border-0 border-bottom rounded-0"
                                               name="email" id="email" placeholder="name@example.com" required>
                                        <label for="email" class="form-label">이메일</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control border-0 border-bottom rounded-0"
                                               name="password" id="password" placeholder="Password" required>
                                        <label for="password" class="form-label">비밀번호</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="d-grid">
                                        <button class="btn btn-lg btn-dark rounded-10 fs-6"
                                                style="color: white; background-color: #0D31B2" type="button" onclick="loginBtn()">로그인
                                        </button>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="text-end">
                                        <a href="${contextPath}/member/identify" class="text-decoration-none">회원가입</a>
                                        <a href="${contextPath}/member/passwordUpdate?identify=host"
                                           class="link-secondary text-decoration-none">비밀번호 찾기</a>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
<%--                    <div class="col-12 col-lg-2 d-flex align-items-center justify-content-center gap-3 flex-lg-column">--%>
<%--                        <div class="bg-dark h-100 d-none d-lg-block" style="width: 1px; --bs-bg-opacity: .1;"></div>--%>
<%--                        <div class="bg-dark w-100 d-lg-none" style="height: 1px; --bs-bg-opacity: .1;"></div>--%>
<%--                        <div>or</div>--%>
<%--                        <div class="bg-dark h-100 d-none d-lg-block" style="width: 1px; --bs-bg-opacity: .1;"></div>--%>
<%--                        <div class="bg-dark w-100 d-lg-none" style="height: 1px; --bs-bg-opacity: .1;"></div>--%>
<%--                    </div>--%>
<%--                    <div class="col-12 col-lg-5 d-flex align-items-center">--%>
<%--                        <div class="d-flex gap-3 flex-column">--%>
<%--                            <a id="kakao-login-btn"><img src="${contextPath}/images/kakao_login.png" height="50"--%>
<%--                                                         alt="카카오 로그인 버튼"/></a>--%>
<%--                            <a id="naver-login-btn"><img src="${contextPath}/images/naver_login.png" height="50"--%>
<%--                                                         alt="네이버 로그인 버튼"/></a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
                </div>
            </div>
        </div>
    </form>
</div>
</section>
</body>
</html>
