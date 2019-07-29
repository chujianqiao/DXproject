package com.trs.zhq.service;

import com.trs.zhq.entity.UseSpace;

public interface UseSpaceService {

    public String insertUseSpace(UseSpace useSpace);

    public UseSpace selectUseSpaceById(Integer id);

    public String updateUseSpace(UseSpace useSpace);

    public String getUseSpace();

    public void deleteUseSpace(String UIDS);

}
