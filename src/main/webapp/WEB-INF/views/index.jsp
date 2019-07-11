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
    <link rel="stylesheet" href="<%=basePath%>static/js/layui/css/layui.css" media="all">
    <script src="<%=basePath%>static/js/jquery-2.1.1.min.js"></script>
    <script src="<%=basePath%>static/js/jquery.min.js"></script>
    <script src="<%=basePath%>static/js/layui/layui.js" charset="utf-8"></script>

</head>
<style>
    .searchWord{
        float: left;
        width: 85%;
        height: 52px;
        border: 0px;
    }
    .searchBotton{
        width: 15%;
        height: 52px;
    }
    .searchDiv{
        width: 50%;
        margin-left: auto;
        margin-right: auto;
        margin-top: 150px;
    }
    .typeButton{
        width: 50%;
        margin-top: 50px;
        margin-left: auto;
        margin-right: auto;
    }
</style>
<body background="<%=basePath %>static/images/timg0.jpg">
<div>
    <ul class="layui-nav">
        <li class="layui-nav-item">
            <a href="<%=basePath%>index">首页</a>
        </li>
        <img src="<%=basePath %>static/images/biaoti.png">
        <li class="layui-nav-item" style="float: right">
            <a href="<%=basePath %>logout">注销</a>
        </li>
        <li class="layui-nav-item" style="float: right">
            <a href="javascript:;"><%=request.getSession().getAttribute("CONSOLEUSERNAME") %></a>
            <dl class="layui-nav-child"> <!-- 二级菜单 -->
                <dd><a onclick="updatePass('<%=request.getSession().getAttribute("CONSOLEUSERNAME") %>')" href="javascript:;">修改密码</a></dd>
            </dl>
        </li>
        <%
            if (request.getSession().getAttribute("CONSOLEUSERNAME").equals("admin")){
        %>
            <li class="layui-nav-item" style="float: right">
                <a href="<%=basePath %>user/searchUsers?start=1&end=10">用户管理</a>
            </li>
        <%
            }
        %>
    </ul>
    <div class="searchDiv layui-tab layui-tab-card" lay-filter="demo">
        <ul class="layui-tab-title" style="width: 100%">
            <li class="layui-this">文档</li>
            <li>数据</li>
        </ul>
        <form id="searchForm" class="layui-form layui-form-pane" action="<%=basePath%>searchData">
            <input type="text" name="start" value="1" hidden>
            <input type="text" name="end" value="10" hidden>
            <input type="text" id="searchType" name="searchType" value="0" hidden>
            <input type="text" id="searchWord" name="searchWord" autocomplete="off" placeholder="请输入检索词" class="layui-input searchWord">
            <button type="button" onclick="toSearch()" class="layui-btn searchBotton">检索</button>
        </form>
    </div>
    <div class="typeButton">
        <a href="<%=basePath%>toImport?dataType=0" class="layui-btn layui-btn-normal layui-btn-radius">频谱数据</a>
        <a href="<%=basePath%>toImport?dataType=1" class="layui-btn layui-btn-normal layui-btn-radius">模采数据</a>
        <a href="<%=basePath%>toImport?dataType=2" class="layui-btn layui-btn-normal layui-btn-radius">数采数据</a>
        <a href="<%=basePath%>toImport?dataType=3" class="layui-btn layui-btn-normal layui-btn-radius">信源数据</a>
        <br><br>
        <a href="<%=basePath%>toImport?dataType=4" class="layui-btn layui-btn-normal layui-btn-radius">网络采集数据</a>
        <a href="<%=basePath%>toImport?dataType=5" class="layui-btn layui-btn-normal layui-btn-radius">二进制数据</a>
        <a href="<%=basePath%>toImport?dataType=6" class="layui-btn layui-btn-normal layui-btn-radius">分析工程文件数据</a>
        <a href="<%=basePath%>toImport?dataType=7" class="layui-btn layui-btn-normal layui-btn-radius">程序数据</a>
    </div>

</div>

</body>
<script type="text/javascript">

    function toSearch() {
        var searchWord = $("#searchWord").val()
        if(searchWord==null||searchWord==""||searchWord.trim()==null||searchWord.trim()==""){
            layui.use('layer', function(){
                var layer = layui.layer;
                layer.open({
                    title: '提示'
                    ,content: '检索词不能为空！'
                });
            });

        }else{
            $("#searchForm").submit();
        }
    }

    layui.use('element', function(){
        var element = layui.element;

        //一些事件监听
        element.on('tab(demo)', function(data){
            if(this.innerHTML=="数据"){
                $("#searchType").attr("value",1);
            }else {
                $("#searchType").attr("value",0);
            }
            console.log(this.innerHTML);
        });
    });
    
    function toImport() {

    }

    function updatePass(USERNAME) {
        layui.use('layer', function() {
            layer.open({
                type: 2,
                area: ['1000px', '500px'],
                content: '<%=basePath%>user/toUpdatePass?USERNAME=' + USERNAME, //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']

            });
        });
    }

</script>

