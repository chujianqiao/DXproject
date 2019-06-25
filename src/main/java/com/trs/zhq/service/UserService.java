package com.trs.zhq.service;

import com.trs.hybase.client.TRSRecord;
import com.trs.zhq.entity.*;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface UserService {
    String insertUser(Users users);
}
