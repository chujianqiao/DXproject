package com.trs.zhq.service.impl;

import com.trs.hybase.client.TRSConnection;
import com.trs.hybase.client.TRSInputRecord;
import com.trs.hybase.client.TRSRecord;
import com.trs.hybase.client.TRSResultSet;
import com.trs.hybase.client.params.SearchParams;
import com.trs.zhq.entity.*;
import com.trs.zhq.service.TRSSearchService;
import com.trs.zhq.service.UserService;
import com.trs.zhq.util.HybaseConnectionUtil;
import com.trs.zhq.util.MD5Util;
import com.trs.zhq.util.StringUtil;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


@Service("UserService")
public class UserServiceImpl implements UserService {

    @Override
    public String insertUser(Users user){
        TRSConnection conn = HybaseConnectionUtil.getHybaseConnection();
        List<TRSInputRecord> recordList = new ArrayList<TRSInputRecord>();
        TRSInputRecord record = new TRSInputRecord();
        SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd");
        String dbName = "sj_users";
        user.setID(StringUtil.idGenerator());
        TRSResultSet resultSet=null;
        String selectWhere = "USERNAME:"+user.getUSERNAME();
        SearchParams param = new SearchParams();
        int flag = 0;
        try {
            resultSet = conn.executeSelect(dbName,selectWhere,0,10000,param);
            for(int i = 0; i < resultSet.size(); i++){
                resultSet.moveNext();
                if (resultSet.get().getString("USERNAME").equals(user.getUSERNAME())){
                    flag = 1;
                }

            }
            if (flag == 0){
                record.addColumn("USERNAME",user.getUSERNAME());
                String pass_md5 = MD5Util.MD5(user.getPASSWORD().toUpperCase()
                        + MD5Util.MD5(user.getID()));
                record.addColumn("PASSWORD",pass_md5);
                record.addColumn("UID",user.getID());
                record.addColumn("STATUS",1);
                recordList.add(record);

                conn.executeInsert(dbName,recordList);
                return "success";
            }else {
                return "same";
            }

        }catch (Exception e){
            e.printStackTrace();
            return "false";
        }
    }
}
