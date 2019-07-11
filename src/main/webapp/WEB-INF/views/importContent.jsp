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
    .searchDiv{
        width: 55%;
        margin: 30px auto;
    }
    .mustInput{
        width: 500px;
    }
</style>
<body background="<%=basePath %>static/images/timg2.jpg">
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
<div class="searchDiv">
    <%--<div style="width: 700px;margin: auto;padding-top: 25px">
        <button type="button" class="layui-btn layui-btn-primary layui-btn-sm">
            <a href="<%=basePath%>index">
                <i class="layui-icon">
                    < 首页
                </i>
            </a>
        </button>
    </div>--%>
    <form class="layui-form layui-form-pane" action="<%=basePath%>importData" target="target" enctype="multipart/form-data">
        <input hidden name="dataType" value="${dataType}">
        <input hidden name="TFileName" id="TFileName" value="">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 20%">文件名</label>
            <div class="layui-input-inline" style="width: 70%">
                <input type="text" name="SFILENAME" lay-verify="required" placeholder="请输入文件名" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid" style="color: red;">*必填</div>
        </div>
        <c:if test="${fieldString.indexOf('SPROGTYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">存储芯片名称</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="SPROGTYPE"  lay-verify="required" placeholder="请输入存储芯片名称" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SPROCESSORTYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">可编程芯片名称</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="SPROCESSORTYPE"  lay-verify="required" placeholder="请输入可编程芯片名称" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SFPGATYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">FPGA芯片名称</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="SFPGATYPE"  lay-verify="required" placeholder="请输入FPGA芯片名称" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SEQUIPMENT')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">设备名称</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="SEQUIPMENT"  lay-verify="required" placeholder="请输入设备名称" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SPROJECTNAME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">隶属课题名称</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="SPROJECTNAME"  lay-verify="required" placeholder="请输入隶属课题名称" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NFILELEN')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">文件长度</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" id="NFILELEN" name="NFILELEN"  lay-verify="required|number" placeholder="请输入文件长度" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SCOMFREQSPAN')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">通信频段</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SCOMFREQSPAN" placeholder="请输入通信频段" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSATELLITE_NAME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">卫星名称</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SSATELLITE_NAME" placeholder="请输入卫星名称" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SORBIT_POS')>0}">
            <c:if test="${dataType==3}">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 20%">卫星轨道位置</label>
                    <div class="layui-input-inline" style="width: 70%">
                        <input type="text" name="SORBIT_POS" lay-verify="required" placeholder="请输入卫星轨道位置" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid" style="color: red;">*必填</div>
                </div>
            </c:if>
            <c:if test="${dataType!=3}">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 20%">卫星轨道位置</label>
                    <div class="layui-input-inline"  style="width: 78%">
                        <input type="text" name="SORBIT_POS" placeholder="请输入卫星轨道位置" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </c:if>
        </c:if>
        <c:if test="${fieldString.indexOf('SPOLARIZATION_TYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">极化方式</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SPOLARIZATION_TYPE" placeholder="请输入极化方式" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('STRANSPONDR')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">转发器名称</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="STRANSPONDR" placeholder="请输入转发器名称" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSTATION_NAME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">阵地名称</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SSTATION_NAME" placeholder="请输入阵地名称" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NCARRIERFREQ')>0}">
            <c:if test="${dataType==3}">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 20%">载波中心频率</label>
                    <div class="layui-input-inline"  style="width: 78%">
                        <input type="text" name="NCARRIERFREQ" lay-verify="number" placeholder="请输入载波中心频率" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </c:if>
            <c:if test="${dataType!=3}">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 20%">载波中心频率</label>
                    <div class="layui-input-inline" style="width: 70%">
                        <input type="text" name="NCARRIERFREQ"  lay-verify="required|number" placeholder="请输入载波中心频率" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid" style="color: red;">*必填</div>
                </div>
            </c:if>
        </c:if>
        <c:if test="${fieldString.indexOf('SSOURCETYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">信源类型</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="SSOURCETYPE"  lay-verify="required" placeholder="请输入信源类型" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSOURCECODETYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">信源编码类型</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="SSOURCECODETYPE"  lay-verify="required" placeholder="请输入信源编码类型" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NSOURCERATE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">信源速率</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="NSOURCERATE" lay-verify="number" placeholder="请输入信源速率" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSQUIPMENT_NAME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">设备名称</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SSQUIPMENT_NAME" placeholder="请输入设备名称" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSQUIPMENT_CHAN')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">设备通道号</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SSQUIPMENT_CHAN" placeholder="请输入设备通道号" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NCARRIER_FREQ')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">载波频率</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="NCARRIER_FREQ"  lay-verify="required|number" placeholder="请输入载波频率" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NIF_FREQ')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">中频频率</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="NIF_FREQ"  lay-verify="required|number" placeholder="请输入中频频率" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NCARRIER_BAND')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">载波带宽</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="NCARRIER_BAND"  lay-verify="required|number" placeholder="请输入载波带宽" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NDATA_SAMPLERATE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">采样频率</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="NDATA_SAMPLERATE"  lay-verify="required|number" placeholder="请输入采样频率" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SFILTER_BAND')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">模拟滤波器带宽</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SFILTER_BAND" placeholder="请输入模拟滤波器带宽" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSAMPLEDATA_TYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">数据类型</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SSAMPLEDATA_TYPE" placeholder="请输入数据类型" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSAMPLEGAIN_TYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">增益方式</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SSAMPLEGAIN_TYPE" placeholder="请输入增益方式" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSAMPLEGAIN')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">增益值</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SSAMPLEGAIN" lay-verify="number" placeholder="请输入增益值" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NDATA_CARRIERFREQ')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">采样后中心频率</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="NDATA_CARRIERFREQ" lay-verify="number" placeholder="请输入采样后中心频率" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NFREQ_START')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">起始频率</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="NFREQ_START"  lay-verify="required|number" placeholder="请输入起始频率" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NFREQ_STOP')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">结束频率</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="NFREQ_STOP"  lay-verify="required|number" placeholder="请输入结束频率" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NBANDDATA_SPLRATE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">采样频率</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="NBANDDATA_SPLRATE"  lay-verify="required|number" placeholder="请输入采样频率" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NBANDDATA_FFTNUM')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">FFT点数</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="NBANDDATA_FFTNUM"  lay-verify="required|number" placeholder="请输入FFT点数" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NSIGLEVEL')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">参考信号电平</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="NSIGLEVEL" lay-verify="number" placeholder="请输入参考信号电平" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NBANDDATA_TYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">频谱数据类型</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="NBANDDATA_TYPE"  lay-verify="required|number" placeholder="请输入频谱数据类型" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NSPECTRUM_DIVISION')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">频率分辨率</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="NSPECTRUM_DIVISION" lay-verify="number" placeholder="请输入频率分辨率" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('DDATA_RECBTIME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">记录开始时间</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="DDATA_RECBTIME" placeholder="请输入记录开始时间" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('DDATA_RECETIME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">记录结束时间</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="DDATA_RECETIME" placeholder="请输入记录结束时间" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NDATA_RECDURATION')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">记录持续时间</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="NDATA_RECDURATION" lay-verify="number" placeholder="请输入记录持续时间" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NSAMPLE_BITS')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">采样精度</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="NSAMPLE_BITS" lay-verify="number" placeholder="请输入采样精度" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NSAMPLE_VALID_BITS')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">数据有效位</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="NSAMPLE_VALID_BITS" lay-verify="number" placeholder="请输入数据有效位" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SMODULATIONMODE')>0}">
            <c:if test="${dataType==2}">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 20%">调制方式</label>
                    <div class="layui-input-inline" style="width: 70%">
                        <input type="text" name="SMODULATIONMODE" lay-verify="required" placeholder="请输入调制方式" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid" style="color: red;">*必填</div>
                </div>
            </c:if>
            <c:if test="${dataType!=2}">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 20%">调制方式</label>
                    <div class="layui-input-inline"  style="width: 78%">
                        <input type="text" name="SMODULATIONMODE" placeholder="请输入调制方式" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </c:if>
        </c:if>
        <c:if test="${fieldString.indexOf('NMODULATIONRATE')>0}">
            <c:if test="${dataType==2}">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 20%">调制速率</label>
                    <div class="layui-input-inline" style="width: 70%">
                        <input type="text" name="NMODULATIONRATE" lay-verify="required|number" placeholder="请输入调制速率" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid" style="color: red;">*必填</div>
                </div>
            </c:if>
            <c:if test="${dataType!=2}">
                <div class="layui-form-item">
                    <label class="layui-form-label" style="width: 20%">调制速率</label>
                    <div class="layui-input-inline"  style="width: 78%">
                        <input type="text" name="NMODULATIONRATE" lay-verify="number" placeholder="请输入调制速率" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </c:if>
        </c:if>
        <c:if test="${fieldString.indexOf('SCODETYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">信道编码类型</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SCODETYPE" placeholder="请输入信道编码类型" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SCODERATIO')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">信道编码码率</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SCODERATIO" placeholder="请输入信道编码码率" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSCRAMBLERTYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">扰码类型</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SSCRAMBLERTYPE" placeholder="请输入扰码类型" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSCRAMBLERRATIO')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">扰码码率</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SSCRAMBLERRATIO" placeholder="请输入扰码码率" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SMODFRAMETYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">调制成帧结构类型</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SMODFRAMETYPE" placeholder="请输入调制成帧结构类型" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SFRAMERATIO')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">成帧类型码率</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SFRAMERATIO" placeholder="请输入成帧类型码率" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NINFORATE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">信息速率</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="NINFORATE" lay-verify="number" placeholder="请输入信息速率" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SBUSINESSTYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">复接信号类型</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="SBUSINESSTYPE" placeholder="请输入复接信号类型" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SNETSIGNALTYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">网络信号类型</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="SNETSIGNALTYPE"  lay-verify="required" placeholder="请输入网络信号类型" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NDEMOD_ERR')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">解调误码率</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="NDEMOD_ERR" lay-verify="number" placeholder="请输入解调误码率" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NDECOD_ERR')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">译码误码率</label>
                <div class="layui-input-inline"  style="width: 78%">
                    <input type="text" name="NDECOD_ERR" lay-verify="number" placeholder="请输入译码误码率" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SNETDATA_TYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">网络数据格式</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="SNETDATA_TYPE"  lay-verify="required" placeholder="请输入网络数据格式" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SIS_COMPRESS_SAVE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">存储方式</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="SIS_COMPRESS_SAVE"  lay-verify="required" placeholder="请输入存储方式" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SUPLOADER')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">上传人</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="SUPLOADER"  lay-verify="required|number" placeholder="请输入上传人" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('DUPLOADERTIME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">上传时间</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="DUPLOADERTIME"  lay-verify="required" placeholder="请输入上传时间" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('BISTOSHARE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label" style="width: 20%">是否共享</label>
                <div class="layui-input-inline" style="width: 70%">
                    <input type="text" name="BISTOSHARE"  lay-verify="required" placeholder="请输入是否共享" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SUSERCOMMENT')>0}">
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">用户注释信息</label>
                <div class="layui-input-block">
                    <textarea name="SUSERCOMMENT" placeholder="请输入用户注释信息" class="layui-textarea"></textarea>
                </div>
            </div>
        </c:if>
        <br><br><br><br><br><br>

        <input hidden id="TRSID" name="TRSID" value="${TRSID}" >
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button id="dataSubmit" class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>

    </form>
    <form id="fileForm" name="fileForm" class="layui-form layui-form-pane" style="position: absolute;margin-top: -150px;width: 55%" enctype="multipart/form-data">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 87%">
                <input class="form-control" type="file" name="file" id="file" style="float: left"/>
            </label><button id="btn" class="layui-btn" type="button">上传文件</button>
        </div>
        <div class="progress">
            <%--<div id="progress" class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 1%;">
                0%
            </div>--%>
            <div class="layui-progress layui-progress-big" lay-showPercent="yes">
                <div id="progress" class="layui-progress-bar layui-bg-green" lay-percent="0%"></div>
            </div>
        </div>

    </form>

    <iframe name="target" id="target" width="800px" height="100px" hidden></iframe>
</div>
</div>
</body>
<script>
    //Demo
    layui.use('form', function(){
        var form = layui.form;
        document.getElementById("dataSubmit").disabled=true;
        $("#dataSubmit").attr("class","layui-btn layui-btn-disabled");
        //监听提交
        form.on('submit(formDemo)', function(data){
            //layer.msg(JSON.stringify(data.field));

            layer.msg("正在上传。");
            return true;


        });
    });

    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: "[name='DUPLOADERTIME']" //指定元素
        });
    });
    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: "[name='DDATA_RECBTIME']" //指定元素
        });
    });
    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //执行一个laydate实例
        laydate.render({
            elem: "[name='DDATA_RECETIME']" //指定元素
        });
    });
    layui.use('element', function(){
        var element = layui.element;
    });
</script>
<script>
    $(function () {
        $("#btn").on("click",function () {
            layer.alert("正在上传，请等待文件上传完毕后再提交数据。");
            document.getElementById("dataSubmit").disabled=true;
            var TFileNmae = $("#file").val();
            var pos = TFileNmae.lastIndexOf("\\");
            if(pos != -1){
                TFileNmae = TFileNmae.substring(pos + 1);
            }
            $('#TFileName').attr("value",TFileNmae);
            var oMyForm = new FormData($("#fileForm")[0]);
            oMyForm.append("TFileName", TFileNmae);
            oMyForm.append("TRSID", '${TRSID}');
            oMyForm.append("datatype", ${dataType});
            var xhr = new XMLHttpRequest();
            xhr.upload.addEventListener("progress", uploadProgress, false);
            xhr.addEventListener("load", uploadComplete, false);
            xhr.addEventListener("error", uploadFailed, false);
            xhr.addEventListener("abort", uploadCanceled, false);
            xhr.open("POST", "up");
            xhr.send(oMyForm);
        });

    });
    function uploadProgress(evt) {
        if (evt.lengthComputable) {
            var percentComplete = Math.round(evt.loaded * 100 / evt.total);
            var progress = $("#progress");
            progress.css("width",percentComplete + "%");
            progress.attr("lay-percent",percentComplete + "%");
            $("#progress span").html(percentComplete + "%");
        } else {
            $("#progress").html("无法计算");
        }
    }

    function uploadComplete(evt) {
        /* 当服务器响应后，这个事件就会被触发 */
        alert("上传成功：" + evt.target.responseText);
        var TFileNmae = $("#file").val();
        document.getElementById("dataSubmit").disabled=false;
        $("#dataSubmit").attr("class","layui-btn");
    }

    function uploadFailed(evt) {
        alert("上传失败：" + "上传文件发生了错误");
    }

    function uploadCanceled(evt) {
        alert("上传取消：" + "上传被用户取消或者浏览器断开连接");
    }

</script>