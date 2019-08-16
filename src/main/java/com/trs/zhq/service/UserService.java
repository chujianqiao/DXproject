package com.trs.zhq.service;

import com.trs.zhq.entity.*;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;


@Service
public interface UserService {
    String insertUser(Users users, HttpServletRequest request);
    Users selectUserByUserName(String userName);

    User selectUserByName(String userName);

    String deleteUserData(String userName);
    String updateUser(Users user, HttpServletRequest request);
}
