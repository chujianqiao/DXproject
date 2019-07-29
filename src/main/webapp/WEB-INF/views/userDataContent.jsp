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
<body background="<%=basePath %>static/images/timg2.jpg">
<div>
    <ul class="layui-nav">
        <li class="layui-nav-item">
            <a href="<%=basePath%>index">首页</a>
        </li>
        <img style="width: 800px;" src="<%=basePath %>static/images/biaoti.png">
        <li class="layui-nav-item" style="float: right">
            <a href="<%=basePath %>logout">注销</a>
        </li>
        <li class="layui-nav-item" style="float: right">
            <p><%=request.getSession().getAttribute("CONSOLEUSERNAME") %></p>
        </li>

    </ul>
    <div class="searchDiv layui-tab layui-tab-card" lay-filter="demo">

        <form id="searchForm" class="layui-form layui-form-pane" action="<%=basePath%>user/searchUsers">
            <div class="layui-form-item">
                <input id="start" name="start" value="1" hidden>
                <input id="end" name="end" value="10" hidden>
                <input type="text" id="searchWord" name="searchWord" value="${searchWord}" autocomplete="off" placeholder="请输入用户名" class="layui-input searchWord">
                <input type="text" hidden id="searchWordHidden" name="searchWordHidden" value="${searchWord}" >
                <button type="button" onclick="toSearch()" class="layui-btn searchBotton">检索</button>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">排序类型</label>
                <div class="layui-input-inline" style="width: 130px;">
                    <select id="selectSort" name="selectSort" lay-filter="selectSort" lay-verify="required">
                        <option value=""></option>
                        <option value="RELEVANCE" <c:if test="${selectSort=='RELEVANCE'}">selected</c:if>>按相关度排序</option>
                        <option value="+CREATETIME" <c:if test="${selectSort=='+CREATETIME'}">selected</c:if>>按入库时间正序</option>
                        <option value="-CREATETIME" <c:if test="${selectSort=='-CREATETIME'}">selected</c:if>>按入库时间倒序</option>
                    </select>
                </div>
                <label class="layui-form-label">密级</label>
                <div class="layui-input-inline" style="width: 130px;">
                    <select id="miji" name="miji" lay-filter="selectSort" lay-verify="required">
                        <option value="">全部</option>
                        <option value="秘密" <c:if test="${userMiji=='秘密'}">selected</c:if>>秘密</option>
                        <option value="机密" <c:if test="${userMiji=='机密'}">selected</c:if>>机密</option>
                        <option value="绝密" <c:if test="${userMiji=='绝密'}">selected</c:if>>绝密</option>
                    </select>
                </div>
                <button type="button" class="layui-btn" onclick="toAddUser()" style="float: right">
                    <i class="layui-icon">&#xe608;</i> 添加用户
                </button>
            </div>

        </form>


        <br>

        <table style="width: 100%;text-align: center">
            <thead>
                <tr style="text-align: center">
                    <th class="thData">用户名</th>
                    <th class="thData">创建时间</th>
                    <th class="thData">密级</th>
                    <th class="thData">状态</th>
                    <th class="thData" style="border-right: 0px solid white;">操作</th>
                </tr>
            </thead>
            <%
                int num = 0;
            %>
            <c:forEach items="${resultSet}" var="resultSet">

                <tr <%if (num%2!=0){%>style="background-color: #efefef"<%}%>>
                    <td class="tdData">${resultSet.getString("USERNAME")}</td>
                    <td class="tdData">${resultSet.getString('CREATETIME').substring(0,10)}</td>
                    <td class="tdData">${resultSet.getString("USER_MIJI")}</td>
                    <td class="tdData">
                        <c:if test="${resultSet.getString('STATUS')==1}">正常</c:if>
                        <c:if test="${resultSet.getString('STATUS')==0}">停用</c:if>
                    </td>
                    <td class="tdData" style="width: 85px;border-right: 0px solid white;">
                        <div class="layui-btn-group">
                        <button type="button" title="编辑" onclick="updateUser('${resultSet.getString("USERNAME")}')" class="layui-btn layui-btn-sm">
                            <i class="layui-icon">&#xe642;</i>
                        </button>
                        <button type="button" title="删除" onclick="ifDeleteUser('${resultSet.getString("USERNAME")}')" class="layui-btn layui-btn-sm">
                            <i class="layui-icon">&#xe640;</i>
                        </button>
                        </div>
                    </td>
                </tr>
                <%
                    num = num+1;
                %>
            </c:forEach>
            <tbody id="tbodyData">

            </tbody>
        </table>


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
            $("#searchForm").submit();

        });
    });

    function ifDeleteUser(USERNAME){
        layui.use('layer', function() {
            layer.confirm("是否删除用户名为：" + USERNAME + "的用户？", {icon: 3, title: '提示'}, function (index) {
                deleteUser(USERNAME);
                layer.close(index);
            });
        });
    }

    function deleteUser(USERNAME){
        $.ajax({
            type:"POST",
            url:"<%=basePath%>user/deleteUser?userName="+USERNAME,
            dataType:"text",
            async:false,
            success:function(data){
                console.log(data);
                if(data == "success"){
                    layui.use('layer', function(){
                        var layer = layui.layer;
                        layer.open({
                            title: '提示'
                            ,content: '删除成功！'
                        });
                    });
                    location.reload([true]);
                }else{
                    layui.use('layer', function(){
                        var layer = layui.layer;
                        layer.open({
                            title: '提示'
                            ,content: '删除失败！'
                        });
                    });
                }
            },
            error:function(jqXHR){
                console.log(jqXHR);
                layui.use('layer', function(){
                    var layer = layui.layer;
                    layer.open({
                        title: '提示'
                        ,content: '删除！'
                    });
                });
            }
        });
    }

    function updateUser(USERNAME){
        layer.open({
            type: 2,
            area: ['1000px', '500px'],
            content: '<%=basePath%>user/toUpdateUser?userName='+USERNAME, //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
            end: function () {
                location.reload([true]);
            }
        });
    }

    function toAddUser() {
        layer.open({
            type: 2,
            area: ['1000px', '500px'],
            content: '<%=basePath%>toRegister?flag=1', //这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com', 'no']
            end: function () {
                location.reload([true]);
            }
        });
    }
</script>