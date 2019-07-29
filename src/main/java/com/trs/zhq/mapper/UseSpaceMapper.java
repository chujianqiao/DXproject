package com.trs.zhq.mapper;

import com.trs.zhq.entity.UseSpace;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Mapper
@Component
public interface UseSpaceMapper {

        public String insertUseSpace(UseSpace useSpace);

        public UseSpace selectUseSpaceById(String UID);

        public String updateUseSpace(UseSpace useSpace);

        public void deleteUseSpace(String UIDS);
}
