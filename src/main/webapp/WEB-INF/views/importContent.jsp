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
        width: 700px;
        margin: 30px auto;
    }
    .mustInput{
        width: 500px;
    }
</style>
<body>
<div>
<ul class="layui-nav">
    <li class="layui-nav-item">
        <a href="<%=basePath%>index">首页</a>
    </li>
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
            <label class="layui-form-label">SFILENAME</label>
            <div class="layui-input-inline" style="width: 500px">
                <input type="text" name="SFILENAME" lay-verify="required" placeholder="请输入SFILENAME" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid" style="color: red;">*必填</div>
        </div>
        <c:if test="${fieldString.indexOf('SPROGTYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SPROGTYPE</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="SPROGTYPE"  lay-verify="required" placeholder="请输入SPROGTYPE" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SPROCESSORTYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SPROCESSORTYPE</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="SPROCESSORTYPE"  lay-verify="required" placeholder="请输入SPROCESSORTYPE" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SFPGATYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SFPGATYPE</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="SFPGATYPE"  lay-verify="required" placeholder="请输入SFPGATYPE" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SEQUIPMENT')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SEQUIPMENT</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="SEQUIPMENT"  lay-verify="required" placeholder="请输入SEQUIPMENT" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SPROJECTNAME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SPROJECTNAME</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="SPROJECTNAME"  lay-verify="required" placeholder="请输入SPROJECTNAME" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NFILELEN')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NFILELEN</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" id="NFILELEN" name="NFILELEN"  lay-verify="required|number" placeholder="请输入NFILELEN" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SCOMFREQSPAN')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SCOMFREQSPAN</label>
                <div class="layui-input-block">
                    <input type="text" name="SCOMFREQSPAN" placeholder="请输入SCOMFREQSPAN" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSATELLITE_NAME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SSATELLITE_NAME</label>
                <div class="layui-input-block">
                    <input type="text" name="SSATELLITE_NAME" placeholder="请输入SSATELLITE_NAME" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SORBIT_POS')>0}">
            <c:if test="${dataType==3}">
                <div class="layui-form-item">
                    <label class="layui-form-label">SORBIT_POS</label>
                    <div class="layui-input-inline" style="width: 500px">
                        <input type="text" name="SORBIT_POS" lay-verify="required" placeholder="请输入SORBIT_POS" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid" style="color: red;">*必填</div>
                </div>
            </c:if>
            <c:if test="${dataType!=3}">
                <div class="layui-form-item">
                    <label class="layui-form-label">SORBIT_POS</label>
                    <div class="layui-input-block">
                        <input type="text" name="SORBIT_POS" placeholder="请输入SORBIT_POS" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </c:if>
        </c:if>
        <c:if test="${fieldString.indexOf('SPOLARIZATION_TYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SPOLARIZATION_TYPE</label>
                <div class="layui-input-block">
                    <input type="text" name="SPOLARIZATION_TYPE" placeholder="请输入SPOLARIZATION_TYPE" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('STRANSPONDR')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">STRANSPONDR</label>
                <div class="layui-input-block">
                    <input type="text" name="STRANSPONDR" placeholder="请输入STRANSPONDR" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSTATION_NAME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SSTATION_NAME</label>
                <div class="layui-input-block">
                    <input type="text" name="SSTATION_NAME" placeholder="请输入SSTATION_NAME" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NCARRIERFREQ')>0}">
            <c:if test="${dataType==3}">
                <div class="layui-form-item">
                    <label class="layui-form-label">NCARRIERFREQ</label>
                    <div class="layui-input-block">
                        <input type="text" name="NCARRIERFREQ" lay-verify="number" placeholder="请输入NCARRIERFREQ" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </c:if>
            <c:if test="${dataType!=3}">
                <div class="layui-form-item">
                    <label class="layui-form-label">NCARRIERFREQ</label>
                    <div class="layui-input-inline" style="width: 500px">
                        <input type="text" name="NCARRIERFREQ"  lay-verify="required|number" placeholder="请输入NCARRIERFREQ" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid" style="color: red;">*必填</div>
                </div>
            </c:if>
        </c:if>
        <c:if test="${fieldString.indexOf('SSOURCETYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SSOURCETYPE</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="SSOURCETYPE"  lay-verify="required" placeholder="请输入SSOURCETYPE" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSOURCECODETYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SSOURCECODETYPE</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="SSOURCECODETYPE"  lay-verify="required" placeholder="请输入SSOURCECODETYPE" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NSOURCERATE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NSOURCERATE</label>
                <div class="layui-input-block">
                    <input type="text" name="NSOURCERATE" lay-verify="number" placeholder="请输入NSOURCERATE" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSQUIPMENT_NAME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SSQUIPMENT_NAME</label>
                <div class="layui-input-block">
                    <input type="text" name="SSQUIPMENT_NAME" placeholder="请输入SSQUIPMENT_NAME" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSQUIPMENT_CHAN')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SSQUIPMENT_CHAN</label>
                <div class="layui-input-block">
                    <input type="text" name="SSQUIPMENT_CHAN" placeholder="请输入SSQUIPMENT_CHAN" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NCARRIER_FREQ')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NCARRIER_FREQ</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="NCARRIER_FREQ"  lay-verify="required|number" placeholder="请输入NCARRIER_FREQ" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NIF_FREQ')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NIF_FREQ</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="NIF_FREQ"  lay-verify="required|number" placeholder="请输入NIF_FREQ" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NCARRIER_BAND')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NCARRIER_BAND</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="NCARRIER_BAND"  lay-verify="required|number" placeholder="请输入NCARRIER_BAND" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NDATA_SAMPLERATE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NDATA_SAMPLERATE</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="NDATA_SAMPLERATE"  lay-verify="required|number" placeholder="请输入NDATA_SAMPLERATE" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SFILTER_BAND')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SFILTER_BAND</label>
                <div class="layui-input-block">
                    <input type="text" name="SFILTER_BAND" placeholder="请输入SFILTER_BAND" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSAMPLEDATA_TYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SSAMPLEDATA_TYPE</label>
                <div class="layui-input-block">
                    <input type="text" name="SSAMPLEDATA_TYPE" placeholder="请输入SSAMPLEDATA_TYPE" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSAMPLEGAIN_TYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SSAMPLEGAIN_TYPE</label>
                <div class="layui-input-block">
                    <input type="text" name="SSAMPLEGAIN_TYPE" placeholder="请输入SSAMPLEGAIN_TYPE" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSAMPLEGAIN')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SSAMPLEGAIN</label>
                <div class="layui-input-block">
                    <input type="text" name="SSAMPLEGAIN" lay-verify="number" placeholder="请输入SSAMPLEGAIN" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NDATA_CARRIERFREQ')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NDATA_CARRIERFREQ</label>
                <div class="layui-input-block">
                    <input type="text" name="NDATA_CARRIERFREQ" lay-verify="number" placeholder="请输入NDATA_CARRIERFREQ" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NFREQ_START')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NFREQ_START</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="NFREQ_START"  lay-verify="required|number" placeholder="请输入NFREQ_START" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NFREQ_STOP')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NFREQ_STOP</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="NFREQ_STOP"  lay-verify="required|number" placeholder="请输入NFREQ_STOP" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NBANDDATA_SPLRATE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NBANDDATA_SPLRATE</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="NBANDDATA_SPLRATE"  lay-verify="required|number" placeholder="请输入NBANDDATA_SPLRATE" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NBANDDATA_FFTNUM')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NBANDDATA_FFTNUM</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="NBANDDATA_FFTNUM"  lay-verify="required|number" placeholder="请输入NBANDDATA_FFTNUM" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NSIGLEVEL')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NSIGLEVEL</label>
                <div class="layui-input-block">
                    <input type="text" name="NSIGLEVEL" lay-verify="number" placeholder="请输入NSIGLEVEL" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NBANDDATA_TYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NBANDDATA_TYPE</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="NBANDDATA_TYPE"  lay-verify="required|number" placeholder="请输入NBANDDATA_TYPE" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NSPECTRUM_DIVISION')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NSPECTRUM_DIVISION</label>
                <div class="layui-input-block">
                    <input type="text" name="NSPECTRUM_DIVISION" lay-verify="number" placeholder="请输入NSPECTRUM_DIVISION" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('DDATA_RECBTIME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">DDATA_RECBTIME</label>
                <div class="layui-input-block">
                    <input type="text" name="DDATA_RECBTIME" placeholder="请输入DDATA_RECBTIME" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('DDATA_RECETIME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">DDATA_RECETIME</label>
                <div class="layui-input-block">
                    <input type="text" name="DDATA_RECETIME" placeholder="请输入DDATA_RECETIME" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NDATA_RECDURATION')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NDATA_RECDURATION</label>
                <div class="layui-input-block">
                    <input type="text" name="NDATA_RECDURATION" lay-verify="number" placeholder="请输入NDATA_RECDURATION" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NSAMPLE_BITS')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NSAMPLE_BITS</label>
                <div class="layui-input-block">
                    <input type="text" name="NSAMPLE_BITS" lay-verify="number" placeholder="请输入NSAMPLE_BITS" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NSAMPLE_VALID_BITS')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NSAMPLE_VALID_BITS</label>
                <div class="layui-input-block">
                    <input type="text" name="NSAMPLE_VALID_BITS" lay-verify="number" placeholder="请输入NSAMPLE_VALID_BITS" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SMODULATIONMODE')>0}">
            <c:if test="${dataType==2}">
                <div class="layui-form-item">
                    <label class="layui-form-label">SMODULATIONMODE</label>
                    <div class="layui-input-inline" style="width: 500px">
                        <input type="text" name="SMODULATIONMODE" lay-verify="required" placeholder="请输入SMODULATIONMODE" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid" style="color: red;">*必填</div>
                </div>
            </c:if>
            <c:if test="${dataType!=2}">
                <div class="layui-form-item">
                    <label class="layui-form-label">SMODULATIONMODE</label>
                    <div class="layui-input-block">
                        <input type="text" name="SMODULATIONMODE" placeholder="请输入SMODULATIONMODE" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </c:if>
        </c:if>
        <c:if test="${fieldString.indexOf('NMODULATIONRATE')>0}">
            <c:if test="${dataType==2}">
                <div class="layui-form-item">
                    <label class="layui-form-label">NMODULATIONRATE</label>
                    <div class="layui-input-inline" style="width: 500px">
                        <input type="text" name="NMODULATIONRATE" lay-verify="required|number" placeholder="请输入NMODULATIONRATE" autocomplete="off" class="layui-input">
                    </div>
                    <div class="layui-form-mid" style="color: red;">*必填</div>
                </div>
            </c:if>
            <c:if test="${dataType!=2}">
                <div class="layui-form-item">
                    <label class="layui-form-label">NMODULATIONRATE</label>
                    <div class="layui-input-block">
                        <input type="text" name="NMODULATIONRATE" lay-verify="number" placeholder="请输入NMODULATIONRATE" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </c:if>
        </c:if>
        <c:if test="${fieldString.indexOf('SCODETYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SCODETYPE</label>
                <div class="layui-input-block">
                    <input type="text" name="SCODETYPE" placeholder="请输入SCODETYPE" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SCODERATIO')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SCODERATIO</label>
                <div class="layui-input-block">
                    <input type="text" name="SCODERATIO" placeholder="请输入SCODERATIO" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSCRAMBLERTYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SSCRAMBLERTYPE</label>
                <div class="layui-input-block">
                    <input type="text" name="SSCRAMBLERTYPE" placeholder="请输入SSCRAMBLERTYPE" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SSCRAMBLERRATIO')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SSCRAMBLERRATIO</label>
                <div class="layui-input-block">
                    <input type="text" name="SSCRAMBLERRATIO" placeholder="请输入SSCRAMBLERRATIO" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SMODFRAMETYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SMODFRAMETYPE</label>
                <div class="layui-input-block">
                    <input type="text" name="SMODFRAMETYPE" placeholder="请输入SMODFRAMETYPE" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SFRAMERATIO')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SFRAMERATIO</label>
                <div class="layui-input-block">
                    <input type="text" name="SFRAMERATIO" placeholder="请输入SFRAMERATIO" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NINFORATE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NINFORATE</label>
                <div class="layui-input-block">
                    <input type="text" name="NINFORATE" lay-verify="number" placeholder="请输入NINFORATE" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SBUSINESSTYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SBUSINESSTYPE</label>
                <div class="layui-input-block">
                    <input type="text" name="SBUSINESSTYPE" placeholder="请输入SBUSINESSTYPE" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SNETSIGNALTYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SNETSIGNALTYPE</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="SNETSIGNALTYPE"  lay-verify="required" placeholder="请输入SNETSIGNALTYPE" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NDEMOD_ERR')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NDEMOD_ERR</label>
                <div class="layui-input-block">
                    <input type="text" name="NDEMOD_ERR" lay-verify="number" placeholder="请输入NDEMOD_ERR" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('NDECOD_ERR')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">NDECOD_ERR</label>
                <div class="layui-input-block">
                    <input type="text" name="NDECOD_ERR" lay-verify="number" placeholder="请输入NDECOD_ERR" autocomplete="off" class="layui-input">
                </div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SNETDATA_TYPE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SNETDATA_TYPE</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="SNETDATA_TYPE"  lay-verify="required" placeholder="请输入SNETDATA_TYPE" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SIS_COMPRESS_SAVE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SIS_COMPRESS_SAVE</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="SIS_COMPRESS_SAVE"  lay-verify="required" placeholder="请输入SIS_COMPRESS_SAVE" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SUPLOADER')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">SUPLOADER</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="SUPLOADER"  lay-verify="required|number" placeholder="请输入SUPLOADER" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('DUPLOADERTIME')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">DUPLOADERTIME</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="DUPLOADERTIME"  lay-verify="required" placeholder="请输入DUPLOADERTIME" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('BISTOSHARE')>0}">
            <div class="layui-form-item">
                <label class="layui-form-label">BISTOSHARE</label>
                <div class="layui-input-inline" style="width: 500px">
                    <input type="text" name="BISTOSHARE"  lay-verify="required" placeholder="请输入BISTOSHARE" autocomplete="off" class="layui-input">
                </div>
                <div class="layui-form-mid" style="color: red;">*必填</div>
            </div>
        </c:if>
        <c:if test="${fieldString.indexOf('SUSERCOMMENT')>0}">
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">SUSERCOMMENT</label>
                <div class="layui-input-block">
                    <textarea name="SUSERCOMMENT" placeholder="请输入SUSERCOMMENT" class="layui-textarea"></textarea>
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
    <form id="fileForm" name="fileForm" class="layui-form layui-form-pane" style="position: absolute;margin-top: -150px;" enctype="multipart/form-data">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 600px">
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
            $('#TFileName').attr("value",TFileNmae);
            var pos = TFileNmae.lastIndexOf("\\");
            if(pos != -1){
                TFileNmae = TFileNmae.substring(pos + 1);
            }
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
    }

    function uploadFailed(evt) {
        alert("上传失败：" + "上传文件发生了错误");
    }

    function uploadCanceled(evt) {
        alert("上传取消：" + "上传被用户取消或者浏览器断开连接");
    }

</script>