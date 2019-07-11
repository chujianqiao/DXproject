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
</head>

<style>
    .searchDiv{
        width: 55%;
        margin: 30px auto;
    }
</style>

<body background="<%=basePath %>static/images/timg2.jpg">
<div>
    <div class="searchDiv">
        <form class="layui-form layui-form-pane" id="register" action="#" target="target" enctype="multipart/form-data">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">原密码</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="password" id="oldpassWord1" lay-verify="required" placeholder="请输入原密码" autocomplete="off" class="layui-input">
                    <input type="password" id="oldpassWord0" name="oldPASSWORD" hidden>
                    <input type="password" value="${USERNAME}" name="USERNAME" hidden>
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">新密码</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="password" id="passWord1" lay-verify="required" placeholder="请输入新密码" autocomplete="off" class="layui-input">
                    <input type="password" id="passWord0" name="PASSWORD" hidden>
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">确认密码</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="password" id="passWord2" lay-verify="required|rePassword" placeholder="请再次输入新密码" autocomplete="off" class="layui-input">
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

        /* 增加回车提交功能 */
        $(document).keypress(function(e) {
            // 回车键事件
            if(e.which == 13) {

            }
        });

    });

    $("#passWord1").blur(function(){
        $("#passWord0").val(hex_md5($("#passWord1").val()));
    })
    $("#oldpassWord1").blur(function(){
        $("#oldpassWord0").val(hex_md5($("#oldpassWord1").val()));
    })

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
            submitRegister();
            return false;


        });
    });

    function submitRegister() {
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "text",//预期服务器返回的数据类型
            url: "<%=basePath%>user/updatePass" ,//url
            data: $('#register').serialize(),
            success: function (result) {
                console.log(result);
                if (result == "success"){
                    layui.use('layer', function(){
                        var layer = layui.layer;
                        layer.open({
                            title: '提示'
                            ,content: '修改成功！'
                        });
                    });
                    window.parent.layer.closeAll();//关闭弹窗
                } else if (result == "falsePass") {
                    layui.use('layer', function(){
                        var layer = layui.layer;
                        layer.open({
                            title: '提示'
                            ,content: '原密码错误，请重新输入！'
                        });
                    });
                } else {
                    layui.use('layer', function(){
                        var layer = layui.layer;
                        layer.open({
                            title: '提示'
                            ,content: '修改失败！'
                        });
                    });
                }
            },
            error : function(e) {
                console.log(e);
                layui.use('layer', function(){
                    var layer = layui.layer;
                    layer.open({
                        title: '提示'
                        ,content: '失败！'
                    });
                });
            }
        });
    }

</script>
</body>

</html>