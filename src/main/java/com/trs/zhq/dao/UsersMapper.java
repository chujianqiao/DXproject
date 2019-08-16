package com.trs.zhq.dao;

import com.trs.zhq.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UsersMapper
{
    User queryByUsername(final String USERNAME);

    int insertUser (final User user);

    int deleteByUserName (final String USERNAME);

    int updateSizeByUsername(@Param("FILESIZE") final String FILESIZE, @Param("USERNAME") final String USERNAME);

    int updateMaxSizeByUsername(@Param("MAXSIZE") final String MAXSIZE, @Param("USERNAME") final String USERNAME);
}
