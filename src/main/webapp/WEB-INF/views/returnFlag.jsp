<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String path = request.getContextPath();
//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    String basePath = path + "/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8"/>
    <title>DX</title>
    <link rel="stylesheet" href="js/layui/css/layui.css" media="all">
    <script src="js/jquery-2.1.1.min.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/layui/layui.js" charset="utf-8"></script>

</head>
<style>

</style>
<body>

</body>
<script>
    layui.use(['layer'],function(){
        var layer =layui.layer;
        if (${flag=="success"}){
            parent.layer.open({
                content: "上传成功"
            });
        }else {
            parent.layer.open({
                content: "上传失败"
            });
        }

    })

</script>