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
    }
    .searchBotton{
        width: 15%;
        height: 52px;
    }
    .searchDiv{
        background-color: white;
        width: 55%;
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
            <p><%=request.getSession().getAttribute("CONSOLEUSERNAME") %></p>
        </li>

    </ul>
    <div class="searchDiv layui-tab layui-tab-card" lay-filter="demo">
        <ul class="layui-tab-title" style="width: 100%">
            <li <c:if test="${searchType==0}">class="layui-this"</c:if>>文档</li>
            <li <c:if test="${searchType==1}">class="layui-this"</c:if>>数据</li>
        </ul>
        <form id="searchForm" class="layui-form layui-form-pane" action="<%=basePath%>searchData">
            <div class="layui-form-item">
                <input id="start" name="start" value="1" hidden>
                <input id="end" name="end" value="10" hidden>
                <input type="text" id="searchType" name="searchType" value="${searchType}" hidden>
                <input type="text" id="searchWord" name="searchWord" value="${searchWord}" autocomplete="off" placeholder="请输入检索词" class="layui-input searchWord">
                <input type="text" hidden id="searchWordHidden" name="searchWordHidden" value="${searchWord}" >
                <button type="button" onclick="toSearch()" class="layui-btn searchBotton">检索</button>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">排序类型</label>
                <div class="layui-input-block" style="width: 130px;">
                    <select id="selectSort" name="selectSort" lay-filter="selectSort" lay-verify="required">
                        <option value=""></option>
                        <c:if test="${searchType==0}">
                            <option value="RELEVANCE" <c:if test="${selectSort=='RELEVANCE'}">selected</c:if>>按相关度排序</option>
                            <option value="+DX_RUKUSHIJIAN" <c:if test="${selectSort=='+DX_RUKUSHIJIAN'}">selected</c:if>>按入库时间正序</option>
                            <option value="-DX_RUKUSHIJIAN" <c:if test="${selectSort=='-DX_RUKUSHIJIAN'}">selected</c:if>>按入库时间倒序</option>
                        </c:if>
                        <c:if test="${searchType==1}">
                            <option value="RELEVANCE" <c:if test="${selectSort=='RELEVANCE'}">selected</c:if>>按相关度排序</option>
                            <option value="+CREATETIME" <c:if test="${selectSort=='+CREATETIME'}">selected</c:if>>按入库时间正序</option>
                            <option value="-CREATETIME" <c:if test="${selectSort=='-CREATETIME'}">selected</c:if>>按入库时间倒序</option>
                        </c:if>
                    </select>
                </div>
            </div>
        </form>

        <br>
        <c:if test="${searchType==0}">
            <table style="width: 100%">
                <thead>
                    <tr style="text-align: center">
                        <th class="thData">标题</th>
                        <th class="thData">描述</th>
                        <th class="thData">入库时间</th>
                        <th class="thData">密级</th>
                        <th class="thData" style="border-right: 0px solid white;">来源</th>
                    </tr>
                </thead>
                <%
                    int num = 0;
                %>
                <c:forEach items="${resultSet}" var="resultSet">

                    <tr <%if (num%2!=0){%>style="background-color: #efefef"<%}%>>
                        <td class="tdData">
                            <c:if test="${resultSet.getString('DX_MIJI')!='机密'}">
                                <a target="_blank" href="<%=basePath%>toDetail?id=${resultSet.getString("DX_ID")}&searchWord=${searchWord }&searchType=${searchType}&dbName=${resultSet.getDbName().replace("system.","")}">${resultSet.getString("DX_BIAOTI")}</a>
                            </c:if>
                            <c:if test="${resultSet.getString('DX_MIJI')=='机密'}">
                                ${resultSet.getString("DX_BIAOTI")}
                            </c:if>
                        </td>
                        <td class="tdData">${resultSet.getString("DX_MIAOSHU")}</td>
                        <td class="tdData">${resultSet.getString('DX_RUKUSHIJIAN').substring(0,10)}</td>
                        <td class="tdData">${resultSet.getString("DX_MIJI")}</td>
                        <td class="tdData" style="border-right: 0px solid white;">${resultSet.getString("DX_LAIYUAN")}</td>
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
            <table style="width: 100%">
                <thead>
                <tr style="text-align: center">
                    <th class="thData">标题</th>
                    <th class="thData">入库时间</th>
                </tr>
                </thead>
                <%
                    int num = 0;
                %>
                <c:forEach items="${resultSet}" var="resultSet">

                    <tr <%if (num%2!=0){%>style="background-color: #efefef"<%}%>>
                        <td class="tdData"><a target="_blank" href="<%=basePath%>toDetail?id=${resultSet.getString("TRSID")}&searchWord=${searchWord }&searchType=${searchType}&dbName=${resultSet.getDbName().replace("system.","")}">${resultSet.getString("SFILENAME")}</a></td>
                        <td class="tdData">${resultSet.getString("CREATETIME").substring(0,10)}</td>
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


    layui.use('form', function(){
        var form = layui.form; //只有执行了这一步，部分表单元素才会自动修饰成功

        form.on('select(selectSort)', function(data){
            toSearch();

        });
    });
</script>