package com.trs.zhq.controller;


import com.trs.hybase.client.TRSRecord;
import com.trs.zhq.entity.User;
import com.trs.zhq.entity.Users;
import com.trs.zhq.service.TRSSearchService;
import com.trs.zhq.service.UseSpaceService;
import com.trs.zhq.service.UserService;
import com.trs.zhq.util.DataBaseConstants;
import com.trs.zhq.util.MD5Util;
import com.trs.zhq.util.RequestUtil;
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

    @Autowired
    private UseSpaceService useSpaceService;

    @RequestMapping("searchUsers")
    public String searchData(String searchWord, int start, int end, String miji, String selectSort, HttpServletRequest request) {
        String userName = (String) request.getSession().getAttribute("CONSOLEUSERNAME");
        if (userName.equals("admin")) {
            if (StringUtils.isEmpty(searchWord)) {
                searchWord = "";
            }
            int startBak = start;
            String searchWordBak = searchWord;
            String mijiBak = miji;
            searchWord = "\"" + searchWord + "\"";
            start = (start - 1) * end;
            String dbName = DataBaseConstants.HYBASEUSERTABLE;
            String searchWhere = "";
            if (searchWordBak == "") {
                searchWhere = "";
            } else {
                searchWhere = "USERNAME:" + searchWord;
            }
            List<TRSRecord> resultSet = new ArrayList<>();
            int count = 0;
            if (StringUtils.isEmpty(selectSort)) {
                selectSort = "RELEVANCE";
            }

            if (!StringUtils.isEmpty(miji)) {
                miji = "\"" + miji + "\"";
                if (searchWhere == "") {
                    searchWhere = "(USER_MIJI:" + miji + ")";
                } else {
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
        }else {
            return "index";
        }
    }

    @RequestMapping("deleteUser")
    @ResponseBody
    public String deleteUser(String userName, String UIDS){
        useSpaceService.deleteUseSpace(UIDS);
        return userService.deleteUserData(userName);
    }

    @RequestMapping("toUpdateUser")
    public String toUpdateUser(String userName, HttpServletRequest request){
        Users user = this.userService.selectUserByUserName(userName);
        User user1 = this.userService.selectUserByName(userName);
        user1.setMAXSIZE(Integer.parseInt(user1.getMAXSIZE())/1024 + "");
        request.setAttribute("user",user);
        request.setAttribute("user1",user1);
        return "updateUserContent";
    }

    @RequestMapping("updateUser")
    @ResponseBody
    public String updateUser(Users user, HttpServletRequest request){
        Users userSame = this.userService.selectUserByUserName(user.getUSERNAME());

        if (!StringUtils.isEmpty(userSame.getUSERNAME())){
            if (!userSame.getUID().equals(user.getUID())){
                return "same";
            }

        }

        return this.userService.updateUser(user, request);

    }

    @RequestMapping("toUpdatePass")
    public String toUpdatePass(String USERNAME, HttpServletRequest request){
        request.setAttribute("USERNAME",USERNAME);
        return "updatePass";
    }

    @RequestMapping("updatePass")
    @ResponseBody
    public String updatePass(String USERNAME, String PASSWORD, String oldPASSWORD, HttpServletRequest request){
        Users user = this.userService.selectUserByUserName(USERNAME);
        if (MD5Util.compareWithPasswords(oldPASSWORD.toUpperCase(),
                user.getPASSWORD(), user.getUID())) {
            user.setPASSWORD(PASSWORD);
            return this.userService.updateUser(user, request);
        }else {
            return "falsePass";
        }
    }
}
