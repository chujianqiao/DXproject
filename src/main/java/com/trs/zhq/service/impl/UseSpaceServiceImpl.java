package com.trs.zhq.service.impl;

import com.trs.zhq.entity.UseSpace;
import com.trs.zhq.mapper.UseSpaceMapper;
import com.trs.zhq.service.UseSpaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UseSpaceServiceImpl implements UseSpaceService {

    @Autowired
    private UseSpaceMapper useSpaceMapper;

    @Override
    public String insertUseSpace(UseSpace useSpace) {
        String UID = useSpaceMapper.insertUseSpace(useSpace);
        System.out.println("插入成功：" + useSpace);
        return UID;
    }

    @Override
    public UseSpace selectUseSpaceById(Integer id) {
        return null;
    }

    @Override
    public String updateUseSpace(UseSpace useSpace) {
        return null;
    }

    @Override
    public String getUseSpace() {
        return null;
    }

    @Override
    public void deleteUseSpace(String UIDS) {
        useSpaceMapper.deleteUseSpace(UIDS);
        System.out.println("删除成功：" + UIDS);
    }
}
