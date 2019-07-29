package com.trs.zhq.entity;


import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Entity
@Table(name = "users")
public class UseSpace {

    @Id
    @Column(name = "UID")
    private String UID;
    @Column(name = "USERNAME")
    private String USERNAME;
    @Column(name = "FILESIZE")
    private String FILESIZE;
    @Column(name = "MAXSIZE")
    private String MAXSIZE;

    public UseSpace(String UID, String USERNAME, String FILESIZE, String MAXSIZE) {
        this.UID = UID;
        this.USERNAME = USERNAME;
        this.FILESIZE = FILESIZE;
        this.MAXSIZE = MAXSIZE;
    }
}
