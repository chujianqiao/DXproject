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
import java.util.UUID;


@Service("UserService")
public class UserServiceImpl implements UserService {

    @Override
    public String insertUser(Users user){
        TRSConnection conn = HybaseConnectionUtil.getHybaseConnection();
        List<TRSInputRecord> recordList = new ArrayList<TRSInputRecord>();
        TRSInputRecord record = new TRSInputRecord();
        SimpleDateFormat formatter = new SimpleDateFormat( "yyyy-MM-dd");
        String dbName = "sj_users";
        user.setUID(UUID.randomUUID().toString().replaceAll("-",""));
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
                        + MD5Util.MD5(user.getUID()));
                record.addColumn("PASSWORD",pass_md5);
                record.addColumn("UID",user.getUID());
                record.addColumn("USER_MIJI",user.getUSER_MIJI());
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

    @Override
    public Users selectUserByUserName(String userName){
        Users users = new Users();
        TRSConnection conn = HybaseConnectionUtil.getHybaseConnection();
        SearchParams param = new SearchParams();
        TRSResultSet resultSet=null;
        userName = "\"" + userName + "\"";
        String selectWhere = "USERNAME:"+userName;
        try {
            resultSet = conn.executeSelect("sj_users",selectWhere,0,1,param);
            for(int i = 0; i < resultSet.size(); i++){
                resultSet.moveNext();
                TRSRecord record = resultSet.get();
                users.setUID(record.getString("UID"));
                users.setUSERNAME(record.getString("USERNAME"));
                users.setPASSWORD(record.getString("PASSWORD"));
                users.setSTATUS(record.getString("STATUS"));
                users.setUSER_MIJI(record.getString("USER_MIJI"));
                users.setCREATETIME(record.getString("CREATETIME"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if (conn!=null)conn.close();
        }

        return users;
    }

    @Override
    public String deleteUserData(String userName) {
        TRSConnection conn = HybaseConnectionUtil.getHybaseConnection();
        userName = "\"" + userName + "\"";
        String deleteWhere = "USERNAME:" + userName;
        try {
            long num = conn.executeDeleteQuery("sj_users",deleteWhere);
            if (num > 0){
                return "success";
            }else {
                return "false";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "false";
        }finally {
            if (conn!=null)conn.close();
        }
    }

    @Override
    public String updateUser(Users user) {
        TRSConnection conn = HybaseConnectionUtil.getHybaseConnection();
        SearchParams params = new SearchParams();
        List<TRSInputRecord> newValues = new ArrayList<TRSInputRecord>();

        String selectWhere = "UID:" + user.getUID();
        try {
            TRSResultSet rs = conn.executeSelect("sj_users",selectWhere,0,1,params);
            for (int i = 0;i < rs.size();i++){
                rs.moveNext();
                TRSRecord trsRecord = rs.get();
                TRSInputRecord record = new TRSInputRecord();
                record.setUid(trsRecord.getUid());
                record.addColumn("USERNAME",user.getUSERNAME());
                String pass_md5 = MD5Util.MD5(user.getPASSWORD().toUpperCase()
                        + MD5Util.MD5(user.getUID()));
                record.addColumn("PASSWORD",pass_md5);
                record.addColumn("STATUS",user.getSTATUS());
                record.addColumn("UID",user.getUID());
                record.addColumn("USER_MIJI",user.getUSER_MIJI());
                record.addColumn("CREATETIME",user.getCREATETIME());
                newValues.add(record);
            }
            conn.executeUpdate("sj_users",newValues);
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }finally {
            if (conn!=null)conn.close();
        }

    }
}
