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
    .searchWord{
        float: left;
        width: 600px;
        height: 52px;
    }
    .searchBotton{
        width: 100px;
        height: 52px;
    }
    .searchDiv{
        width: 700px;
        margin: 30px auto;
    }
    .tdData{
        border-right: 10px solid white;
        height: 40px;
    }
    .thData{
        border-right: 10px solid white;
        background-color: #efefef;
        height: 50px;
    }
</style>
<body>
<div>
    <div style="width: 700px;margin: auto;padding-top: 25px">
        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm">
            <a href="<%=basePath%>index">
                <i class="layui-icon">
                    < 首页
                </i>
            </a>
        </button>
    </div>
    <div class="searchDiv layui-tab layui-tab-card" lay-filter="demo">
        <ul class="layui-tab-title" style="width: 699px">
            <li <c:if test="${searchType==0}">class="layui-this"</c:if>>文档</li>
            <li <c:if test="${searchType==1}">class="layui-this"</c:if>>数据</li>
        </ul>
        <form id="searchForm" class="layui-form layui-form-pane" action="<%=basePath%>searchData">
            <div>
                <input id="start" name="start" value="1" hidden>
                <input id="end" name="end" value="10" hidden>
                <input type="text" id="searchType" name="searchType" value="${searchType}" hidden>
                <input type="text" id="searchWord" name="searchWord" value="${searchWord}" autocomplete="off" placeholder="请输入检索词" class="layui-input searchWord">
                <input type="text" hidden id="searchWordHidden" name="searchWordHidden" value="${searchWord}" >
                <button type="button" onclick="toSearch()" class="layui-btn searchBotton">检索</button>
            </div>
        </form>
        <br><br>
        <c:if test="${searchType==0}">
            <table style="width: 710px">
                <thead>
                    <tr style="text-align: center">
                        <th class="thData">标题</th>
                        <th class="thData">描述</th>
                        <th class="thData">入库时间</th>
                        <th class="thData">密级</th>
                        <th class="thData">来源</th>
                    </tr>
                </thead>
                <%
                    int num = 0;
                %>
                <c:forEach items="${resultSet}" var="resultSet">

                    <tr <%if (num%2!=0){%>style="background-color: #efefef"<%}%>>
                        <td class="tdData"><a target="_blank" href="<%=basePath%>toDetail?id=${resultSet.getString("DX_ID")}&searchWord=${searchWord }&dbName=${resultSet.getDbName().replace("system.","")}">${resultSet.getString("DX_BIAOTI")}</a></td>
                        <td class="tdData">${resultSet.getString("DX_MIAOSHU")}</td>
                        <td class="tdData">${resultSet.getString('DX_RUKUSHIJIAN').substring(0,10)}</td>
                        <td class="tdData">${resultSet.getString("DX_MIJI")}</td>
                        <td class="tdData">${resultSet.getString("DX_LAIYUAN")}</td>
                    </tr>
                    <%
                        num = num+1;
                    %>
                </c:forEach>
                <tbody id="tbodyData">

                </tbody>
            </table>
        </c:if>
        <c:if test="${searchType==1}">
            <table style="width: 710px">
                <thead>
                <tr style="text-align: center">
                    <th class="thData">标题</th>
                </tr>
                </thead>
                <%
                    int num = 0;
                %>
                <c:forEach items="${resultSet}" var="resultSet">

                    <tr <%if (num%2!=0){%>style="background-color: #efefef"<%}%>>
                        <td class="tdData"><a target="_blank" href="<%=basePath%>toDetail?id=${resultSet.getString("SFILENAME")}&searchWord=${searchWord }&dbName=${resultSet.getDbName().replace("system.","")}">${resultSet.getString("SFILENAME")}</a></td>
                    </tr>
                    <%
                        num = num+1;
                    %>
                </c:forEach>
                <tbody id="tbodyData">

                </tbody>
            </table>
        </c:if>
        <br>
        <div id="page">

        </div>
    </div>


</div>

</body>
<script type="text/javascript">

    function toSearch() {
        var searchWord = $("#searchWord").val();
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

    layui.use('laypage', function(){
        var laypage = layui.laypage;

        //执行一个laypage实例
        //完整功能
        laypage.render({
            elem: 'page'
            ,limit: 10
            ,count: ${count}
            ,layout: ['count', 'prev', 'page', 'next', 'refresh', 'skip']
            ,curr: ${start} //获取起始页
            ,hash: 'fenye' //自定义hash值
            ,first: '首页'
            ,last: '尾页'
            ,jump: function(obj,first){
                $("#start").attr("value",obj.curr);
                console.log(obj.curr);
                if(!first){
                    $("#searchForm").submit();
                }else{

                }
            }
        });
    });

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
</script>