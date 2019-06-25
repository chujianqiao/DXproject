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

<style>
    .searchDiv{
        width: 700px;
        margin: 30px auto;
    }
</style>

<body>
<div>
    <ul class="layui-nav">
        <li class="layui-nav-item" >
            <a href="<%=basePath%>index">登录</a>
        </li>
        <li class="layui-nav-item">
        </li>
    </ul>
    <div class="searchDiv">
        <form class="layui-form layui-form-pane" action="<%=basePath%>register" target="target" enctype="multipart/form-data">
            <div class="layui-form-item">
                <label class="layui-form-label">用户名：</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="USERNAME" lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">密  码：</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="password" id="passWord1" lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
                    <input type="password" id="passWord0" name="PASSWORD" hidden>
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">确认密码：</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="password" id="passWord2" lay-verify="required|rePassword" placeholder="请再次输入密码" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>
        </form>
        <iframe name="target" id="target" width="800px" height="100px" hidden></iframe>
    </div>
</div>
<script src="<%=basePath %>static/js/layui/layui.js" charset="utf-8">
</script>
<script type="text/javascript">
    var contentH = window.innerHeight;


    $(function(){  //生成验证码
        $('#kaptchaImage').click(function () {
            $(this).hide().attr('src', '<%=basePath%>Kaptcha.jpg?' + Math.floor(Math.random()*100) ).fadeIn(); });


        /* 增加回车提交功能 */
        $(document).keypress(function(e) {
            // 回车键事件
            if(e.which == 13) {

            }
        });

    });

    layui.use('form', function(){
        var form = layui.form;
        form.verify({
            rePassword: function(value) {
                var pwd = $("#passWord1").val();
                if (pwd !== value)
                    return "二次输入的密码不一致！";
            }
        });
        //监听提交
        form.on('submit(formDemo)', function(data){
            //layer.msg(JSON.stringify(data.field));

            if ($("#passWord1").val()!=$("#passWord2").val()){
                layer.msg("两次密码不一致。");
                return false;
            }else{
                layer.msg("正在注册。");
                document.getElementById("passWord0").value=hex_md5( $("#passWord1").val());

                return true;
            }


        });
    });

</script>
</body>

</html>