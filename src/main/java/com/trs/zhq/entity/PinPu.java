package com.trs.zhq.entity;

import java.util.Date;

public class PinPu {
    private String SFILENAME;
    private Long NFILELEN;
    private String SCOMFREQSPAN;
    private String SSATELLITE_NAME;
    private String SORBIT_POS;
    private String SPOLARIZATION_TYPE;
    private String STRANSPONDR;
    private String SSTATION_NAME;
    private String SSQUIPMENT_NAME;
    private String SSQUIPMENT_CHAN;
    private Long NFREQ_START;
    private Long NFREQ_STOP;
    private Long NBANDDATA_SPLRATE;
    private Long NBANDDATA_FFTNUM;
    private Long NSIGLEVEL;
    private Long NBANDDATA_TYPE;
    private Long NSPECTRUM_DIVISION;
    private String DDATA_RECBTIME;
    private String DDATA_RECETIME;
    private Long NDATA_RECDURATION;
    private String SIS_COMPRESS_SAVE;
    private Long SUPLOADER;
    private String SUSERCOMMENT;
    private String BISTOSHARE;

    public String getSFILENAME() {
        return SFILENAME;
    }

    public void setSFILENAME(String SFILENAME) {
        this.SFILENAME = SFILENAME;
    }

    public Long getNFILELEN() {
        return NFILELEN;
    }

    public void setNFILELEN(Long NFILELEN) {
        this.NFILELEN = NFILELEN;
    }

    public String getSCOMFREQSPAN() {
        return SCOMFREQSPAN;
    }

    public void setSCOMFREQSPAN(String SCOMFREQSPAN) {
        this.SCOMFREQSPAN = SCOMFREQSPAN;
    }

    public String getSSATELLITE_NAME() {
        return SSATELLITE_NAME;
    }

    public void setSSATELLITE_NAME(String SSATELLITE_NAME) {
        this.SSATELLITE_NAME = SSATELLITE_NAME;
    }

    public String getSORBIT_POS() {
        return SORBIT_POS;
    }

    public void setSORBIT_POS(String SORBIT_POS) {
        this.SORBIT_POS = SORBIT_POS;
    }

    public String getSPOLARIZATION_TYPE() {
        return SPOLARIZATION_TYPE;
    }

    public void setSPOLARIZATION_TYPE(String SPOLARIZATION_TYPE) {
        this.SPOLARIZATION_TYPE = SPOLARIZATION_TYPE;
    }

    public String getSTRANSPONDR() {
        return STRANSPONDR;
    }

    public void setSTRANSPONDR(String STRANSPONDR) {
        this.STRANSPONDR = STRANSPONDR;
    }

    public String getSSTATION_NAME() {
        return SSTATION_NAME;
    }

    public void setSSTATION_NAME(String SSTATION_NAME) {
        this.SSTATION_NAME = SSTATION_NAME;
    }

    public String getSSQUIPMENT_NAME() {
        return SSQUIPMENT_NAME;
    }

    public void setSSQUIPMENT_NAME(String SSQUIPMENT_NAME) {
        this.SSQUIPMENT_NAME = SSQUIPMENT_NAME;
    }

    public String getSSQUIPMENT_CHAN() {
        return SSQUIPMENT_CHAN;
    }

    public void setSSQUIPMENT_CHAN(String SSQUIPMENT_CHAN) {
        this.SSQUIPMENT_CHAN = SSQUIPMENT_CHAN;
    }

    public Long getNFREQ_START() {
        return NFREQ_START;
    }

    public void setNFREQ_START(Long NFREQ_START) {
        this.NFREQ_START = NFREQ_START;
    }

    public Long getNFREQ_STOP() {
        return NFREQ_STOP;
    }

    public void setNFREQ_STOP(Long NFREQ_STOP) {
        this.NFREQ_STOP = NFREQ_STOP;
    }

    public Long getNBANDDATA_SPLRATE() {
        return NBANDDATA_SPLRATE;
    }

    public void setNBANDDATA_SPLRATE(Long NBANDDATA_SPLRATE) {
        this.NBANDDATA_SPLRATE = NBANDDATA_SPLRATE;
    }

    public Long getNBANDDATA_FFTNUM() {
        return NBANDDATA_FFTNUM;
    }

    public void setNBANDDATA_FFTNUM(Long NBANDDATA_FFTNUM) {
        this.NBANDDATA_FFTNUM = NBANDDATA_FFTNUM;
    }

    public Long getNSIGLEVEL() {
        return NSIGLEVEL;
    }

    public void setNSIGLEVEL(Long NSIGLEVEL) {
        this.NSIGLEVEL = NSIGLEVEL;
    }

    public Long getNBANDDATA_TYPE() {
        return NBANDDATA_TYPE;
    }

    public void setNBANDDATA_TYPE(Long NBANDDATA_TYPE) {
        this.NBANDDATA_TYPE = NBANDDATA_TYPE;
    }

    public Long getNSPECTRUM_DIVISION() {
        return NSPECTRUM_DIVISION;
    }

    public void setNSPECTRUM_DIVISION(Long NSPECTRUM_DIVISION) {
        this.NSPECTRUM_DIVISION = NSPECTRUM_DIVISION;
    }

    public String getDDATA_RECBTIME() {
        return DDATA_RECBTIME;
    }

    public void setDDATA_RECBTIME(String DDATA_RECBTIME) {
        this.DDATA_RECBTIME = DDATA_RECBTIME;
    }

    public String getDDATA_RECETIME() {
        return DDATA_RECETIME;
    }

    public void setDDATA_RECETIME(String DDATA_RECETIME) {
        this.DDATA_RECETIME = DDATA_RECETIME;
    }

    public Long getNDATA_RECDURATION() {
        return NDATA_RECDURATION;
    }

    public void setNDATA_RECDURATION(Long NDATA_RECDURATION) {
        this.NDATA_RECDURATION = NDATA_RECDURATION;
    }

    public String getSIS_COMPRESS_SAVE() {
        return SIS_COMPRESS_SAVE;
    }

    public void setSIS_COMPRESS_SAVE(String SIS_COMPRESS_SAVE) {
        this.SIS_COMPRESS_SAVE = SIS_COMPRESS_SAVE;
    }

    public Long getSUPLOADER() {
        return SUPLOADER;
    }

    public void setSUPLOADER(Long SUPLOADER) {
        this.SUPLOADER = SUPLOADER;
    }

    public String getSUSERCOMMENT() {
        return SUSERCOMMENT;
    }

    public void setSUSERCOMMENT(String SUSERCOMMENT) {
        this.SUSERCOMMENT = SUSERCOMMENT;
    }

    public String getBISTOSHARE() {
        return BISTOSHARE;
    }

    public void setBISTOSHARE(String BISTOSHARE) {
        this.BISTOSHARE = BISTOSHARE;
    }
}
