package com.trs.zhq.service;

import com.trs.zhq.entity.*;
import org.springframework.stereotype.Service;


@Service
public interface UserService {
    String insertUser(Users users);
    Users selectUserByUserName(String userName);

    String deleteUserData(String userName);
    String updateUser(Users user);
}
