package com.trs.zhq.entity;


public class FenXi {
    private String SFILENAME;
    private Long NFILELEN;
    private String SPROCESSORTYPE;
    private String SEQUIPMENT;
    private String SPROJECTNAME;
    private String SUPLOADER;
    private String DUPLOADERTIME;
    private String SUSERCOMMENT;

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

    public String getSPROCESSORTYPE() {
        return SPROCESSORTYPE;
    }

    public void setSPROCESSORTYPE(String SPROCESSORTYPE) {
        this.SPROCESSORTYPE = SPROCESSORTYPE;
    }

    public String getSEQUIPMENT() {
        return SEQUIPMENT;
    }

    public void setSEQUIPMENT(String SEQUIPMENT) {
        this.SEQUIPMENT = SEQUIPMENT;
    }

    public String getSPROJECTNAME() {
        return SPROJECTNAME;
    }

    public void setSPROJECTNAME(String SPROJECTNAME) {
        this.SPROJECTNAME = SPROJECTNAME;
    }

    public String getSUPLOADER() {
        return SUPLOADER;
    }

    public void setSUPLOADER(String SUPLOADER) {
        this.SUPLOADER = SUPLOADER;
    }

    public String getDUPLOADERTIME() {
        return DUPLOADERTIME;
    }

    public void setDUPLOADERTIME(String DUPLOADERTIME) {
        this.DUPLOADERTIME = DUPLOADERTIME;
    }

    public String getSUSERCOMMENT() {
        return SUSERCOMMENT;
    }

    public void setSUSERCOMMENT(String SUSERCOMMENT) {
        this.SUSERCOMMENT = SUSERCOMMENT;
    }
}
