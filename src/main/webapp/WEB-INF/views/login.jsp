<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String basePath = path+"/";
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>
        登录
    </title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="<%=basePath %>static/css/x-admin.css" media="all">
    <link rel="stylesheet" href="<%=basePath %>static/css/font.css" type="text/css">
    <link rel="stylesheet" href="<%=basePath %>static/css/xadmin.css" type="text/css">
    <script src="<%=basePath %>static/js/jquery-2.1.1.min.js"></script>
    <script src="<%=basePath %>static/js/layui/layui.js"></script>
    <script src="<%=basePath %>static/js/md5.js"></script>
    <script src="<%=basePath %>static/js/xadmin.js"></script>
    <script src="<%=basePath %>static/js/rootPath.js"></script>
    <script src="<%=basePath %>static/js/commons.js"></script>
    <script src="<%=basePath %>static/js/login.js"></script>
</head>

<body>
<div class="whole_bg" id="whole_bg">
    <div class="whole">
        <div class="x-box">
            <div class="x-mid">
                <div class="input">
                    <div class="user_login">
                        <h1>用户登录</h1>
                        <div class="login_solid">
                            <div class="login_solid_t"></div>
                        </div>
                    </div>
                    <%-- 	<form method="post" class="layui-form" action="" >
                            <input name="username" id="username"  placeholder="用户名"  type="text" lay-verify="required" value="admin" class="layui-input" >
                            <hr class="hr15">
                            <input name="password" id="passwords" lay-verify="required" placeholder="密码"  type="password" value="admin"  class="layui-input">
                            <hr class="hr15">
                            <input value="${flag }"   type="hidden" id="login_flag">
                             <span id="no_login_span" style="float:right;margin-bottom:5px;color:red;display:none;">您还未登录或登录超时，请先登录！</span>
                            <input value="登录" lay-submit lay-filter="login" id="loginbutton" style="width:100%;" type="button">
                            <hr class="hr20" >
                        </form> --%>
                    <form method="post" class="layui-form" action="" >
                        <div class="layui-form-item x-login-box">
                            <label for="username" class="layui-form-label">
                                <img src="<%=basePath %>static/images/user_name.png" alt="" />
                            </label>
                            <div class="layui-input-inline">
                                <input type="text" id="username" name="username" required="" lay-verify="username"
                                       autocomplete="off" placeholder="请输入用户名" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item x-login-box">
                            <label for="username" class="layui-form-label">
                                <img src="<%=basePath %>static/images/password.png" alt="" />
                            </label>
                            <div class="layui-input-inline">
                                <input value="${flag }"   type="hidden" id="login_flag">
                                <input type="password" id="passwords" name="password" required="" lay-verify="pass"
                                       autocomplete="off" placeholder="******" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item" id="login_btn">
                            <input value="登录" class="layui-btn" lay-filter="login" id="yidai_login" style="width:100%;" onclick="login()" type="button">
                            <br><br>
                            <input value="注册" class="layui-btn" lay-filter="register" id="yidai_register" style="width:100%;" onclick="register()" type="button">
                        </div>
                    </form>
                </div>

            </div>
        </div>
        <!--				<p style="color:#fff;text-align: center;">Copyright © 2017.Company name All rights X-admin </p>-->
    </div>
</div>
<script src="<%=basePath %>static/js/layui/layui.js" charset="utf-8">
</script>
<script type="text/javascript">
    var contentH = window.innerHeight;
    var whole_bg = document.getElementById('whole_bg');
    whole_bg.style.height = contentH + "px";


    $(function(){  //生成验证码
        $('#kaptchaImage').click(function () {
            $(this).hide().attr('src', '<%=basePath%>Kaptcha.jpg?' + Math.floor(Math.random()*100) ).fadeIn(); });


        /* 增加回车提交功能 */
        $(document).keypress(function(e) {
            // 回车键事件
            if(e.which == 13) {
                login();
            }
        });

    });

    function register(){
        window.location.href=contentp_path+'toRegister?flag=0';
    }

    function login(){
        var username = $("#username").val();
        var passwords = hex_md5( $("#passwords").val());
        //var kaptcha_to =$("#kaptcha").val();
        //console.log(kaptcha_to);
        //if(kaptcha_to!=''){
            $.ajax({
                type: "POST",//方法类型
                url: contentp_path+'toLogin',
                data: {/*kaptcha:kaptcha_to,*/passwords:passwords,username:username,code:''},
                async:false,
                success: function (result) {

                    if(result=='success'){
                        window.location.href=contentp_path+'index';
                    }else if(result == 'statusFalse'){
                        messageStrTips('用户已被停用，请联系管理员！');
                        changeCode();
                    }else if(result == 'ERROT_STATUS'){
                        messageStrTips('用户状态错误，请联系管理人员核实身份！');
                        changeCode();
                    }else if(result == 'ERROR_NOT'){
                        messageStrTips('登录失败，验证码错误！');
                        changeCode();
                    }else{
                        messageStrTips('登陆失败，身份信息错误！');
                        changeCode();
                    }
                },
                error : function() {
                    messageStrTips('登陆失败，请稍后重试！');
                    changeCode();
                }
            });
        //}else{
        //    messageStrTips('请输入验证码！');
        //}




    }


    function changeCode() {  //刷新
        $('#kaptchaImage').hide().attr('src', '<%=basePath%>Kaptcha.jpg?' + Math.floor(Math.random()*100) ).fadeIn();
        event.cancelBubble=true;
    }

</script>
</body>

</html>