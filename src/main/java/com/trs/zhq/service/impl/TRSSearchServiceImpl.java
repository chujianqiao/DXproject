package com.trs.zhq.service.impl;

import com.trs.hybase.client.*;
import com.trs.hybase.client.params.SearchParams;
import com.trs.zhq.entity.*;
import com.trs.zhq.service.TRSSearchService;
import com.trs.zhq.util.DataBaseConstants;
import com.trs.zhq.util.HybaseConnectionUtil;
import com.trs.zhq.util.SelectFiledUtil;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Service("TRSSearchService")
public class TRSSearchServiceImpl implements TRSSearchService {
    @Override
    public List<TRSRecord> searchData(String dbName, String selectWhere, String selectSort, int start, int end) {
        List<TRSRecord> dataList = new ArrayList();
        TRSConnection conn = HybaseConnectionUtil.getHybaseConnection();
        SearchParams param = new SearchParams();
        // 设置结果排序 方式为相关度设置结果排序
        param.setSortMethod("RELEVANCE");
        // 设置返回结果字段为“标题” 与正文
        if(dbName.indexOf("wendang")>0){
            param.setColorColumns("DX_BIAOTI;DX_ZHENGWEN");
        }else{
            param.setColorColumns("SFILENAME;SUSERCOMMENT");
        }

        TRSResultSet resultSet=null;
        try {
            resultSet = conn.executeSelect(dbName,selectWhere,start,end,param);
            for(int i = 0; i < resultSet.size(); i++){
                resultSet.moveNext();
                TRSRecord record = resultSet.get();
                dataList.add(record);
            }
            //System.out.println(resultSet.getRecord(0).getString("DUPLOADERTIME"));
            //System.out.println(dataList.get(0).getString("SFILENAME"));
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if (conn!=null)conn.close();
        }
        return dataList;
    }

    @Override
    public int searchDataCount(String dbName, String selectWhere, String selectSort, int start, int end) {
        TRSConnection conn = HybaseConnectionUtil.getHybaseConnection();
        SearchParams param = new SearchParams();
        TRSResultSet resultSet=null;
        try {
            resultSet = conn.executeSelect(dbName,selectWhere,start,end,param);
            //System.out.println(resultSet.getRecord(0).getString("DUPLOADERTIME"));
            //System.out.println(dataList.get(0).getString("SFILENAME"));
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if (conn!=null)conn.close();
        }
        return resultSet.size();
    }

    @Override
    public String insertData(ChengXu chengXu, ErJinZhi erJinZhi, FenXi fenXi,
                           MoCai moCai, PinPu pinPu, ShuCai shuCai, WangLuo wangLuo,
                           XinYuan xinYuan, int dataType) {
        TRSConnection conn = HybaseConnectionUtil.getHybaseConnection();
        List<TRSInputRecord> recordList = new ArrayList<TRSInputRecord>();
        TRSInputRecord record = new TRSInputRecord();
        SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd");
        String dbName = "";
        Date date1 = null;
        Date date2 = null;
        try {
            if(dataType==0){
                dbName = "sj_pinpu";
                if (!pinPu.getDDATA_RECBTIME().equals("")&&pinPu.getDDATA_RECBTIME()!=null){
                    date1 = formatter.parse(pinPu.getDDATA_RECBTIME());
                }
                if (!pinPu.getDDATA_RECETIME().equals("")&&pinPu.getDDATA_RECETIME()!=null){
                    date2 = formatter.parse(pinPu.getDDATA_RECETIME());
                }
                record.addColumn("SFILENAME",pinPu.getSFILENAME());
                record.addColumn("NFILELEN",pinPu.getNFILELEN());
                record.addColumn("SCOMFREQSPAN",pinPu.getSCOMFREQSPAN());
                record.addColumn("SSATELLITE_NAME",pinPu.getSSATELLITE_NAME());
                record.addColumn("SORBIT_POS",pinPu.getSORBIT_POS());
                record.addColumn("SPOLARIZATION_TYPE",pinPu.getSPOLARIZATION_TYPE());
                record.addColumn("STRANSPONDR",pinPu.getSTRANSPONDR());
                record.addColumn("SSTATION_NAME",pinPu.getSSTATION_NAME());
                record.addColumn("SSQUIPMENT_NAME",pinPu.getSSQUIPMENT_NAME());
                record.addColumn("SSQUIPMENT_CHAN",pinPu.getSSQUIPMENT_CHAN());
                record.addColumn("NFREQ_START",pinPu.getNFREQ_START());
                record.addColumn("NFREQ_STOP",pinPu.getNFREQ_STOP());
                record.addColumn("NBANDDATA_SPLRATE",pinPu.getNBANDDATA_SPLRATE());
                record.addColumn("NBANDDATA_FFTNUM",pinPu.getNBANDDATA_FFTNUM());
                record.addColumn("NSIGLEVEL",pinPu.getNSIGLEVEL());
                record.addColumn("NBANDDATA_TYPE",pinPu.getNBANDDATA_TYPE());
                record.addColumn("NSPECTRUM_DIVISION",pinPu.getNSPECTRUM_DIVISION());
                record.addColumn("DDATA_RECBTIME",date1);
                record.addColumn("DDATA_RECETIME",date2);
                record.addColumn("NDATA_RECDURATION",pinPu.getNDATA_RECDURATION());
                record.addColumn("SIS_COMPRESS_SAVE",pinPu.getSIS_COMPRESS_SAVE());
                record.addColumn("SUPLOADER",pinPu.getSUPLOADER());
                record.addColumn("SUSERCOMMENT",pinPu.getSUSERCOMMENT());
                record.addColumn("BISTOSHARE",pinPu.getBISTOSHARE());
            }else if(dataType==1){
                dbName = "sj_mocai";
                if (!moCai.getDDATA_RECBTIME().equals("")&&moCai.getDDATA_RECBTIME()!=null){
                    date1 = formatter.parse(moCai.getDDATA_RECBTIME());
                }
                if (!moCai.getDDATA_RECETIME().equals("")&&moCai.getDDATA_RECETIME()!=null){
                    date2 = formatter.parse(moCai.getDDATA_RECETIME());
                }
                record.addColumn("SFILENAME",moCai.getSFILENAME());
                record.addColumn("NFILELEN",moCai.getNFILELEN());
                record.addColumn("SCOMFREQSPAN",moCai.getSCOMFREQSPAN());
                record.addColumn("SSATELLITE_NAME",moCai.getSSATELLITE_NAME());
                record.addColumn("SORBIT_POS",moCai.getSORBIT_POS());
                record.addColumn("SPOLARIZATION_TYPE",moCai.getSPOLARIZATION_TYPE());
                record.addColumn("STRANSPONDR",moCai.getSTRANSPONDR());
                record.addColumn("SSTATION_NAME",moCai.getSSTATION_NAME());
                record.addColumn("SSQUIPMENT_NAME",moCai.getSSQUIPMENT_NAME());
                record.addColumn("SSQUIPMENT_CHAN",moCai.getSSQUIPMENT_CHAN());
                record.addColumn("NCARRIER_FREQ",moCai.getNCARRIER_FREQ());
                record.addColumn("NIF_FREQ",moCai.getNIF_FREQ());
                record.addColumn("NCARRIER_BAND",moCai.getNCARRIER_BAND());
                record.addColumn("NDATA_SAMPLERATE",moCai.getNDATA_SAMPLERATE());
                record.addColumn("SFILTER_BAND",moCai.getSFILTER_BAND());
                record.addColumn("SSAMPLEDATA_TYPE",moCai.getSSAMPLEDATA_TYPE());
                record.addColumn("SSAMPLEGAIN_TYPE",moCai.getSSAMPLEGAIN_TYPE());
                record.addColumn("SSAMPLEGAIN",moCai.getSSAMPLEGAIN());
                record.addColumn("NDATA_CARRIERFREQ",moCai.getNDATA_CARRIERFREQ());
                record.addColumn("DDATA_RECBTIME",date1);
                record.addColumn("DDATA_RECETIME",date2);
                record.addColumn("NDATA_RECDURATION",moCai.getNDATA_RECDURATION());
                record.addColumn("NSAMPLE_BITS",moCai.getNSAMPLE_BITS());
                record.addColumn("NSAMPLE_VALID_BITS",moCai.getNSAMPLE_VALID_BITS());
                record.addColumn("SIS_COMPRESS_SAVE",moCai.getSIS_COMPRESS_SAVE());
                record.addColumn("SUPLOADER",moCai.getSUPLOADER());
                record.addColumn("SUSERCOMMENT",moCai.getSUSERCOMMENT());
            }else if(dataType==2){
                dbName = "sj_shucai";
                if (!shuCai.getDDATA_RECBTIME().equals("")&&shuCai.getDDATA_RECBTIME()!=null){
                    date1 = formatter.parse(shuCai.getDDATA_RECBTIME());
                }
                if (!shuCai.getDDATA_RECETIME().equals("")&&shuCai.getDDATA_RECETIME()!=null){
                    date2 = formatter.parse(shuCai.getDDATA_RECETIME());
                }
                record.addColumn("SFILENAME",shuCai.getSFILENAME());
                record.addColumn("NFILELEN",shuCai.getNFILELEN());
                record.addColumn("SCOMFREQSPAN",shuCai.getSCOMFREQSPAN());
                record.addColumn("SSATELLITE_NAME",shuCai.getSSATELLITE_NAME());
                record.addColumn("SORBIT_POS",shuCai.getSORBIT_POS());
                record.addColumn("SPOLARIZATION_TYPE",shuCai.getSPOLARIZATION_TYPE());
                record.addColumn("STRANSPONDR",shuCai.getSTRANSPONDR());
                record.addColumn("NCARRIERFREQ",shuCai.getNCARRIERFREQ());
                record.addColumn("SSQUIPMENT_NAME",shuCai.getSSQUIPMENT_NAME());
                record.addColumn("SSQUIPMENT_CHAN",shuCai.getSSQUIPMENT_CHAN());
                record.addColumn("DDATA_RECBTIME",date1);
                record.addColumn("DDATA_RECETIME",date2);
                record.addColumn("NDATA_RECDURATION",shuCai.getNDATA_RECDURATION());
                record.addColumn("SMODULATIONMODE",shuCai.getSMODULATIONMODE());
                record.addColumn("NMODULATIONRATE",shuCai.getNMODULATIONRATE());
                record.addColumn("SCODETYPE",shuCai.getSCODETYPE());
                record.addColumn("SCODERATIO",shuCai.getSCODERATIO());
                record.addColumn("SSCRAMBLERTYPE",shuCai.getSSCRAMBLERTYPE());
                record.addColumn("SSCRAMBLERRATIO",shuCai.getSSCRAMBLERRATIO());
                record.addColumn("SMODFRAMETYPE",shuCai.getSMODFRAMETYPE());
                record.addColumn("SFRAMERATIO",shuCai.getSFRAMERATIO());
                record.addColumn("NINFORATE",shuCai.getNINFORATE());
                record.addColumn("SBUSINESSTYPE",shuCai.getSBUSINESSTYPE());
                record.addColumn("NDEMOD_ERR",shuCai.getNDEMOD_ERR());
                record.addColumn("NDECOD_ERR",shuCai.getNDECOD_ERR());
                record.addColumn("SIS_COMPRESS_SAVE",shuCai.getSIS_COMPRESS_SAVE());
                record.addColumn("SUPLOADER",shuCai.getSUPLOADER());
                record.addColumn("SUSERCOMMENT",shuCai.getSUSERCOMMENT());
            }else if(dataType==3){
                dbName = "sj_xinyuan";
                if (!xinYuan.getDDATA_RECBTIME().equals("")&&xinYuan.getDDATA_RECBTIME()!=null){
                    date1 = formatter.parse(xinYuan.getDDATA_RECBTIME());
                }
                if (!xinYuan.getDDATA_RECETIME().equals("")&&xinYuan.getDDATA_RECETIME()!=null){
                    date2 = formatter.parse(xinYuan.getDDATA_RECETIME());
                }
                record.addColumn("SFILENAME",xinYuan.getSFILENAME());
                record.addColumn("NFILELEN",xinYuan.getNFILELEN());
                record.addColumn("SCOMFREQSPAN",xinYuan.getSCOMFREQSPAN());
                record.addColumn("SSATELLITE_NAME",xinYuan.getSSATELLITE_NAME());
                record.addColumn("SORBIT_POS",xinYuan.getSORBIT_POS());
                record.addColumn("SPOLARIZATION_TYPE",xinYuan.getSPOLARIZATION_TYPE());
                record.addColumn("STRANSPONDR",xinYuan.getSFILENAME());
                record.addColumn("NCARRIERFREQ",xinYuan.getNCARRIERFREQ());
                record.addColumn("SSOURCETYPE",xinYuan.getSSOURCETYPE());
                record.addColumn("SSOURCECODETYPE",xinYuan.getSSOURCECODETYPE());
                record.addColumn("NSOURCERATE",xinYuan.getNSOURCERATE());
                record.addColumn("DDATA_RECBTIME",date1);
                record.addColumn("DDATA_RECETIME",date2);
                record.addColumn("NDATA_RECDURATION",xinYuan.getNDATA_RECDURATION());
                record.addColumn("SIS_COMPRESS_SAVE",xinYuan.getSIS_COMPRESS_SAVE());
                record.addColumn("SUPLOADER",xinYuan.getSUPLOADER());
                record.addColumn("SUSERCOMMENT",xinYuan.getSUSERCOMMENT());
            }else if(dataType==4){
                dbName = "sj_wangluo";
                if (!wangLuo.getDDATA_RECBTIME().equals("")&&wangLuo.getDDATA_RECBTIME()!=null){
                    date1 = formatter.parse(wangLuo.getDDATA_RECBTIME());
                }
                if (!wangLuo.getDDATA_RECETIME().equals("")&&wangLuo.getDDATA_RECETIME()!=null){
                    date2 = formatter.parse(wangLuo.getDDATA_RECETIME());
                }
                record.addColumn("SFILENAME",wangLuo.getSFILENAME());
                record.addColumn("NFILELEN",wangLuo.getNFILELEN());
                record.addColumn("SCOMFREQSPAN",wangLuo.getSCOMFREQSPAN());
                record.addColumn("SSATELLITE_NAME",wangLuo.getSSATELLITE_NAME());
                record.addColumn("SORBIT_POS",wangLuo.getSORBIT_POS());
                record.addColumn("SPOLARIZATION_TYPE",wangLuo.getSPOLARIZATION_TYPE());
                record.addColumn("STRANSPONDR",wangLuo.getSTRANSPONDR());
                record.addColumn("NCARRIERFREQ",wangLuo.getNCARRIERFREQ());
                record.addColumn("DDATA_RECBTIME",date1);
                record.addColumn("DDATA_RECETIME",date2);
                record.addColumn("NDATA_RECDURATION",wangLuo.getNDATA_RECDURATION());
                record.addColumn("SMODULATIONMODE",wangLuo.getSMODULATIONMODE());
                record.addColumn("NMODULATIONRATE",wangLuo.getNMODULATIONRATE());
                record.addColumn("SCODETYPE",wangLuo.getSCODETYPE());
                record.addColumn("SCODERATIO",wangLuo.getSCODERATIO());
                record.addColumn("SSCRAMBLERTYPE",wangLuo.getSSCRAMBLERTYPE());
                record.addColumn("SSCRAMBLERRATIO",wangLuo.getSSCRAMBLERRATIO());
                record.addColumn("SMODFRAMETYPE",wangLuo.getSMODFRAMETYPE());
                record.addColumn("SFRAMERATIO",wangLuo.getSFRAMERATIO());
                record.addColumn("NINFORATE",wangLuo.getNINFORATE());
                record.addColumn("SBUSINESSTYPE",wangLuo.getSBUSINESSTYPE());
                record.addColumn("SNETSIGNALTYPE",wangLuo.getSNETSIGNALTYPE());
                record.addColumn("NDEMOD_ERR",wangLuo.getNDEMOD_ERR());
                record.addColumn("NDECOD_ERR",wangLuo.getNDECOD_ERR());
                record.addColumn("SNETDATA_TYPE",wangLuo.getSNETDATA_TYPE());
                record.addColumn("SIS_COMPRESS_SAVE",wangLuo.getSIS_COMPRESS_SAVE());
                record.addColumn("SUSERCOMMENT",wangLuo.getSUSERCOMMENT());
            }else if(dataType==5){
                dbName = "sj_erjinzhi";
                if (!erJinZhi.getDUPLOADERTIME().equals("")&&erJinZhi.getDUPLOADERTIME()!=null){
                    date1 = formatter.parse(erJinZhi.getDUPLOADERTIME());
                }
                record.addColumn("SFILENAME",erJinZhi.getSFILENAME());
                record.addColumn("NFILELEN",erJinZhi.getNFILELEN());
                record.addColumn("SPROGTYPE",erJinZhi.getSPROGTYPE());
                record.addColumn("SPROCESSORTYPE",erJinZhi.getSPROCESSORTYPE());
                record.addColumn("SFPGATYPE",erJinZhi.getSFPGATYPE());
                record.addColumn("SEQUIPMENT",erJinZhi.getSEQUIPMENT());
                record.addColumn("SPROJECTNAME",erJinZhi.getSPROJECTNAME());
                record.addColumn("SUPLOADER",erJinZhi.getSUPLOADER());
                record.addColumn("DUPLOADERTIME",date1);
                record.addColumn("SUSERCOMMENT",erJinZhi.getSUSERCOMMENT());
            }else if(dataType==6){
                dbName = "sj_fenxi";
                if (!fenXi.getDUPLOADERTIME().equals("")&&fenXi.getDUPLOADERTIME()!=null){
                    date1 = formatter.parse(fenXi.getDUPLOADERTIME());
                }
                record.addColumn("SFILENAME",fenXi.getSFILENAME());
                record.addColumn("NFILELEN",fenXi.getNFILELEN());
                record.addColumn("SPROCESSORTYPE",fenXi.getSPROCESSORTYPE());
                record.addColumn("SEQUIPMENT",fenXi.getSEQUIPMENT());
                record.addColumn("SPROJECTNAME",fenXi.getSPROJECTNAME());
                record.addColumn("SUPLOADER",fenXi.getSUPLOADER());
                record.addColumn("DUPLOADERTIME",date1);
                record.addColumn("SUSERCOMMENT",fenXi.getSUSERCOMMENT());
            }else if(dataType==7){
                dbName = "sj_chengxu";
                if (!chengXu.getDUPLOADERTIME().equals("")&&chengXu.getDUPLOADERTIME()!=null){
                    date1 = formatter.parse(chengXu.getDUPLOADERTIME());
                }
                record.addColumn("SFILENAME",chengXu.getSFILENAME());
                record.addColumn("NFILELEN",chengXu.getNFILELEN());
                record.addColumn("SPROGTYPE",chengXu.getSPROGTYPE());
                record.addColumn("SPROJECTNAME",chengXu.getSPROJECTNAME());
                record.addColumn("SIS_COMPRESS_SAVE",chengXu.getSIS_COMPRESS_SAVE());
                record.addColumn("SUPLOADER",chengXu.getSUPLOADER());
                record.addColumn("DUPLOADERTIME",date1);
                record.addColumn("SUSERCOMMENT",chengXu.getSUSERCOMMENT());
            }
            recordList.add(record);

            conn.executeInsert(dbName,recordList);
            return "success";
        }catch (Exception e){
            e.printStackTrace();
            return "false";
        }

    }

}
