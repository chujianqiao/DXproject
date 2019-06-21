package com.trs.zhq.entity;

import java.util.Date;

public class ChengXu {
    private String SFILENAME;
    private Long NFILELEN;
    private String SPROGTYPE;
    private String SPROJECTNAME;
    private String SIS_COMPRESS_SAVE;
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

    public String getSPROGTYPE() {
        return SPROGTYPE;
    }

    public void setSPROGTYPE(String SPROGTYPE) {
        this.SPROGTYPE = SPROGTYPE;
    }

    public String getSPROJECTNAME() {
        return SPROJECTNAME;
    }

    public void setSPROJECTNAME(String SPROJECTNAME) {
        this.SPROJECTNAME = SPROJECTNAME;
    }

    public String getSIS_COMPRESS_SAVE() {
        return SIS_COMPRESS_SAVE;
    }

    public void setSIS_COMPRESS_SAVE(String SIS_COMPRESS_SAVE) {
        this.SIS_COMPRESS_SAVE = SIS_COMPRESS_SAVE;
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
