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
    <title>${title}</title>
    <link rel="stylesheet" href="<%=basePath%>static/js/layui/css/layui.css" media="all">
    <script src="<%=basePath%>static/js/jquery-2.1.1.min.js"></script>
    <script src="<%=basePath%>static/js/jquery.min.js"></script>
    <script src="<%=basePath%>static/js/layui/layui.js" charset="utf-8"></script>

</head>
<style>
    .searchDiv{
        width: 900px;
        margin-left: auto;
        margin-right: auto;
        margin-top: 50px;
    }
</style>
<body>
<div>
    <ul class="layui-nav">
        <li class="layui-nav-item">
            <a href="<%=basePath%>index">首页</a>
        </li>
        <li class="layui-nav-item" style="float: right">
            <a href=""><%=request.getSession().getAttribute("CONSOLEUSERNAME") %></a>
            <dl class="layui-nav-child">
                <dd><a href="<%=basePath %>logout">注销</a></dd>
            </dl>
        </li>
    </ul>
    <div class="searchDiv" style="height: 100px;text-align: center;">
        <span style="line-height: 100px;font-size: 40px">
            ${trsRecord.getString("DX_BIAOTI")}
        </span>
    </div>
    <div style="width: 900px;height: 150px;margin: auto;line-height: 40px;font-size: 20px;">
        <span>
            来源：${trsRecord.getString("DX_LAIYUAN")}
        </span>&nbsp;&nbsp;
        <span>
            属性：${trsRecord.getString("DX_SHUXING")}
        </span>&nbsp;&nbsp;
        <span>
            入库时间：${trsRecord.getString("DX_RUKUSHIJIAN").substring(0,10)}
        </span>&nbsp;&nbsp;
        <span>
            密级：${trsRecord.getString("DX_MIJI")}
        </span>&nbsp;&nbsp;
        <br>
        <span>
            描述：${trsRecord.getString("DX_MIAOSHU")}
        </span>
    </div>
    <div style="width: 900px;height: 600px;margin: auto;padding-top: 50px;line-height: 30px;font-size: 20px;border-top: 2px solid black">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <span>
            ${trsRecord.getString("DX_ZHENGWEN")}
        </span>
    </div>


</div>

</body>
<script type="text/javascript">

</script>