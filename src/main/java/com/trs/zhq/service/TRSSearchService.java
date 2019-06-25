package com.trs.zhq.service;

import com.trs.hybase.client.TRSRecord;
import com.trs.zhq.entity.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface TRSSearchService {
    List<TRSRecord> searchData(String dbName, String selectWhere, String selectSort, int start, int end);
    int searchDataCount(String dbName, String selectWhere, String selectSort, int start, int end);
    String insertData(ChengXu chengXu, ErJinZhi erJinZhi, FenXi fenXi,
                    MoCai moCai, PinPu pinPu, ShuCai shuCai, WangLuo wangLuo,
                    XinYuan xinYuan, int dataType);

    Users selectUserByUserName(String userName);
}
