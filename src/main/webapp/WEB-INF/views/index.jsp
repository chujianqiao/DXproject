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
    <link rel="stylesheet" href="<%=basePath%>js/layui/css/layui.css" media="all">
    <script src="<%=basePath%>js/jquery-2.1.1.min.js"></script>
    <script src="<%=basePath%>js/jquery.min.js"></script>
    <script src="<%=basePath%>js/layui/layui.js" charset="utf-8"></script>

</head>
<style>
    .searchWord{
        float: left;
        width: 600px;
        height: 52px;
        border: 0px;
    }
    .searchBotton{
        width: 100px;
        height: 52px;
    }
    .searchDiv{
        width: 700px;
        margin-left: auto;
        margin-right: auto;
        margin-top: 200px;
    }
    .typeButton{
        width: 700px;
        margin-top: 50px;
        margin-left: auto;
        margin-right: auto;
    }
</style>
<body>
<div>
    <div class="searchDiv layui-tab layui-tab-card" lay-filter="demo">
        <ul class="layui-tab-title" style="width: 699px">
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

    <form id="fileForm" name="fileForm" enctype="multipart/form-data">
        <input class="form-control" type="file" name="file" id="file"/>
        <button id="btn" type="button">提交</button>
    </form>
    <div class="progress">
        <div id="progress" class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 1%;">
            0%
        </div>
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

</script>

<script>
    $(function () {
        $("#btn").on("click",function () {
            var xhr = new XMLHttpRequest();
            xhr.upload.addEventListener("progress", uploadProgress, false);
            xhr.addEventListener("load", uploadComplete, false);
            xhr.addEventListener("error", uploadFailed, false);
            xhr.addEventListener("abort", uploadCanceled, false);
            xhr.open("POST", "up");
            xhr.send(new FormData($("#fileForm")[0]));
        });

    });
    function uploadProgress(evt) {
        if (evt.lengthComputable) {
            var percentComplete = Math.round(evt.loaded * 100 / evt.total);
            var progress = $("#progress");
            progress.css("width",percentComplete + "%");
            progress.html(percentComplete + "%");

        } else {
            $("#progress").html("无法计算");
        }
    }

    function uploadComplete(evt) {
        /* 当服务器响应后，这个事件就会被触发 */
        alert("上传成功：" + evt.target.responseText);
    }

    function uploadFailed(evt) {
        alert("上传失败：" + "上传文件发生了错误");
    }

    function uploadCanceled(evt) {
        alert("上传取消：" + "上传被用户取消或者浏览器断开连接");
    }
</script>