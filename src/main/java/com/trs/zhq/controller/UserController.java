package com.trs.zhq.controller;


import com.trs.hybase.client.TRSRecord;
import com.trs.zhq.entity.Users;
import com.trs.zhq.service.TRSSearchService;
import com.trs.zhq.service.UserService;
import com.trs.zhq.util.DataBaseConstants;
import com.trs.zhq.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping({"/user/"})
public class UserController {

    @Autowired
    private TRSSearchService trsSearchService;

    @Autowired
    private UserService userService;

    @RequestMapping("searchUsers")
    public String searchData(String searchWord, int start, int end, String miji, String selectSort, HttpServletRequest request) {
        if (StringUtils.isEmpty(searchWord)){
            searchWord = "";
        }
        int startBak = start;
        String searchWordBak = searchWord;
        String mijiBak = miji;
        searchWord = "\"" + searchWord + "\"";
        start = (start - 1) * end;
        String dbName = DataBaseConstants.HYBASEUSERTABLE;
        String searchWhere = "";
        if (searchWordBak == ""){
            searchWhere = "";
        }else {
            searchWhere = "USERNAME:" + searchWord;
        }
        List<TRSRecord> resultSet = new ArrayList<>();
        int count = 0;
        if (StringUtils.isEmpty(selectSort)){
            selectSort = "RELEVANCE";
        }

        if (!StringUtils.isEmpty(miji)){
            miji = "\"" + miji + "\"";
            if (searchWhere==""){
                searchWhere = "(USER_MIJI:" + miji + ")";
            }else {
                searchWhere = "(" + searchWhere + ") AND " + "(USER_MIJI:" + miji + ")";
            }
        }

        resultSet = trsSearchService.searchData(dbName, searchWhere, selectSort, start, end);
        count = trsSearchService.searchDataCount(dbName, searchWhere, "", 0, 10000);

        request.setAttribute("count", count);
        request.setAttribute("start", startBak);
        request.setAttribute("searchWord", searchWordBak);
        request.setAttribute("resultSet", resultSet);
        request.setAttribute("userMiji", mijiBak);
        request.setAttribute("selectSort", selectSort);
        return "userDataContent";
    }

    @RequestMapping("deleteUser")
    @ResponseBody
    public String deleteUser(String userName){
        return userService.deleteUserData(userName);
    }

    @RequestMapping("toUpdateUser")
    public String toUpdateUser(String userName, HttpServletRequest request){
        Users user = this.userService.selectUserByUserName(userName);

        request.setAttribute("user",user);
        return "updateUserContent";
    }

    @RequestMapping("updateUser")
    @ResponseBody
    public String updateUser(Users user, HttpServletRequest request){
        Users userSame = this.userService.selectUserByUserName(user.getUSERNAME());

        if (!StringUtils.isEmpty(userSame.getUSERNAME())){
            return "same";
        }

        return this.userService.updateUser(user);

    }
}
