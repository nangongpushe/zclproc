package com.dhc.fastersoft.tag;

/**
 * <p>Title: BHMS</p>
 * <p>Description: 页面级按钮权限控制（如果用户拥有该按钮权限，则显示；否则，不显示该按钮）</p>
 * <p>Copyright: Copyright (c) 2007</p>
 * <p>Company: </p>
 * @author
 * @version 1.0
 */

import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang3.StringUtils;

import com.dhc.fastersoft.common.Constant;
import com.dhc.fastersoft.vo.UserInfoVO;

public class PurviewTag extends TagSupport {
    //功能点ID
    private long funcId;
    //操作点ID
    private String operId;
    //是否为按钮
    private boolean buttonFlag = true;
    //显示的(中文)文字
    private String labelValue;
    //没有权限时，输出生成按钮的名字
    private String buttonName;

    //是否只有本人才能修改：null或者0：否；1：是 2：本人和上级
    private String isSelfEdit;
    //生成本条记录的staffId
    private String staffId;

    public void setFuncId(long funcId) {
        this.funcId = funcId;
    }
    public long getFuncId() {
        return this.funcId;
    }

    public void setOperId(String operId) {
        this.operId = operId;
    }
    public String getOperId() {
        return this.operId;
    }

    public void setLabelValue(String labelValue){
        this.labelValue = labelValue;
    }
    public String getLabelValue(){
        return this.labelValue;
    }

    public boolean getButtonFlag(){
        return this.buttonFlag;
    }
    public void setButtonFlag(boolean buttonFlag){
        this.buttonFlag = buttonFlag;
    }

    public void setButtonName(String buttonName){
        this.buttonName = buttonName;
    }
    public String getButtonName(){
        return this.buttonName;
    }

    public int doStartTag() throws JspException {
        int processBodyOrNot = SKIP_BODY;
        HttpSession session = pageContext.getSession();
        UserInfoVO user = (UserInfoVO)session.getAttribute(Constant.USER_INFO);
        List<String> functions = user.getFunctions();

        if(StringUtils.isEmpty(isSelfEdit)) {
            isSelfEdit = "0";
        }
        int isSelfEditInt = Integer.parseInt(isSelfEdit);
        boolean hasAuthority = false;
        //不登陆直接查看页面时user为空
        if(user != null)
            hasAuthority = functions.contains("M"+this.getFuncId()+"-"+this.getOperId());
        //如果拥有权限，则输出后面的按钮
        boolean hasRight = false;

        if(isSelfEditInt > 0) {

            try {
                if(isSelfEditInt == 1) {
                    if(user.getUserId().equals(staffId.trim())) hasRight = true;
                } else if(isSelfEditInt  == 2) {
//                    UserServiceImpl userService = new UserServiceImpl();
//                    TbSmStaffPO staffPo = userService.getStaffByStaffId(staffId);
//
//                    user.setTreeOrgId(user.getOrgId());
//                    Collection underStaff = userService.getUnderlingStaffs(user);
//                    if(underStaff.contains(staffPo)) {
//                        hasRight = true;
//                    }
                }
            } catch(Exception ex) {
                throw new JspException(ex);
            }
        } else {
            hasRight = true;
        }
        if(hasAuthority && hasRight){

            processBodyOrNot = EVAL_BODY_INCLUDE;
        }else{//否则的话，则输出参数labelValue的值
            JspWriter out = pageContext.getOut();
            try{
                if(this.getLabelValue()!=null){
                    if(this.getButtonFlag()){ //后面输出的是按钮
                        if(this.getButtonName()!=null){
                            out.print("<input type='button' class='xui-btn'  name='" +
                                    this.getButtonName() + "' disabled value='" +
                                    this.getLabelValue() + "'>");
                        }else{
                            out.print("<input type='button' class='xui-btn'  name='button" +
                                    this.getOperId() + "' disabled value='" +
                                    this.getLabelValue() + "'>");
                        }
                    }else{
                        out.print(this.getLabelValue());
                    }
                }else{ //如果没有设置参数labelValue的值，则忽略后面的输出（输出为空）
                    processBodyOrNot = SKIP_BODY;
                }
            }catch(Exception e){

            }
        }
        return processBodyOrNot;
    }
    public PurviewTag() {
    }
    public String getIsSelfEdit() {
        return isSelfEdit;
    }
    public void setIsSelfEdit(String isSelfEdit) {
        this.isSelfEdit = isSelfEdit;
    }
    public String getStaffId() {
        return staffId;
    }
    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }
}