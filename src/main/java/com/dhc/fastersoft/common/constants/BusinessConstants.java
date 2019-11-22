package com.dhc.fastersoft.common.constants;

public interface BusinessConstants {

    /**
     * 直属库
     */
    String CBL = "proviceunit";
    /**
     * 代储库
     */
    String BASE = "base";

    /**
     * originCode="cbl"
     */
    String CBL_CODE = "cbl";


    /***********************************标的物类别*****************************/
    /**
     * 标的物类别：招标采购
     */
    String TENDER_TYPE_ZBCG = "招标采购";
    /**
     * 标的物类别：竞价销售
     */
    String TENDER_TYPE_JJXS = "竞价销售";
    /**
     * 标的物类别：内部销售
     */
    String TENDER_TYPE_NBXS = "内部招标";
    /**
     * 标的物类别：协议销售
     */
    String TENDER_TYPE_XYXS = "协议销售";


    String REMOTE_BASE_URL = "http://10.10.9.23:9099/remote";    // 远程监管的base地址
//    String REMOTE_BASE_URL = "http://127.0.0.1:9099/remote";    // 远程监管的base地址
    String ENTERPRISE_ID = "0c52215eef7a43d1a23ac4ca76cb9804";  // 数据所属公司的ID
}
