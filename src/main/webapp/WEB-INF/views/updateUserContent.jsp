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
        dx
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

<body>
<div>
    <div class="searchDiv">
        <form class="layui-form layui-form-pane" id="updateForm" action="#" target="target" enctype="multipart/form-data">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">用户名</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="USERNAME" lay-verify="required" value="${user.USERNAME}" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">密  码</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="password" id="passWord1" lay-verify="required" value="${user.PASSWORD}" autocomplete="off" class="layui-input">
                    <input type="password" id="passWord0" value="${user.PASSWORD}" name="PASSWORD" hidden>
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">用户密级</label>
                <div class="layui-input-inline" style="width: 70%">
                    <select id="selectMiji" name="USER_MIJI" lay-filter="selectSort" lay-verify="required">
                        <option value="公开" <c:if test="${user.USER_MIJI=='公开'}">selected</c:if>>公开</option>
                        <option value="秘密" <c:if test="${user.USER_MIJI=='秘密'}">selected</c:if>>秘密</option>
                        <option value="机密" <c:if test="${user.USER_MIJI=='机密'}">selected</c:if>>机密</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">用户状态</label>
                <div class="layui-input-inline" style="width: 70%">
                    <select id="selectStatus" name="STATUS" lay-filter="selectSort" lay-verify="required">
                        <option value="0" <c:if test="${user.STATUS=='0'}">selected</c:if>>停用</option>
                        <option value="1" <c:if test="${user.STATUS=='1'}">selected</c:if>>正常</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">创建时间</label>
                <div class="layui-input-inline"  style="width: 70%">
                    <input type="text" name="CREATETIME" value="${user.CREATETIME.substring(0,10).replaceAll("/","-")}" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item" hidden>
                <label class="layui-form-label">UID：</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="UID" lay-verify="required" value="${user.UID}" autocomplete="off" class="layui-input">
                </div>
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
    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: "[name='CREATETIME']", //指定元素
            trigger: "click"
        });
    });

    $("#passWord1").blur(function(){
        if ($("#passWord0").val() == $("#passWord1").val()){

        }else {
            $("#passWord0").val(hex_md5($("#passWord1").val()));
        }
    })

    layui.use('form', function(){
        var form = layui.form;

        //监听提交
        form.on('submit(formDemo)', function(data){
            submitUpdate();
            return false;
        });
    });

    function submitUpdate() {
        $.ajax({
            //几个参数需要注意一下
            type: "POST",//方法类型
            dataType: "text",//预期服务器返回的数据类型
            url: "<%=basePath%>user/updateUser" ,//url
            data: $('#updateForm').serialize(),
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
                } else if (result == "same") {
                    layui.use('layer', function(){
                        var layer = layui.layer;
                        layer.open({
                            title: '提示'
                            ,content: '用户名重复，请重新输入！'
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
                        ,content: '修改失败！'
                    });
                });
            }
        });
    }
</script>
</body>

</html>