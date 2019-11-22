package com.dhc.fastersoft.vo;

import java.util.HashMap;
import java.util.List;

public class UserInfoVO {
    private String userId;
    private String userName;
    private String[] roleIds;
    /** 用户权限集合 */
    private List<String> functions;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String[] getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(String[] roleIds) {
        this.roleIds = roleIds;
    }

    public List<String> getFunctions() {
        return functions;
    }

    public void setFunctions(List<String> functions) {
        this.functions = functions;
    }
}
