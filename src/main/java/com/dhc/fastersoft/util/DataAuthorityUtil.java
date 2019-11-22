package com.dhc.fastersoft.util;

import com.dhc.fastersoft.common.shrio.token.manager.TokenManager;
import com.dhc.fastersoft.dao.StorageWarehouseDao;
import com.dhc.fastersoft.entity.StorageWarehouse;
import com.dhc.fastersoft.entity.system.SysUser;
import com.dhc.fastersoft.service.StorageStoreHouseService;
import com.dhc.fastersoft.service.StorageWarehouseService;
import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class DataAuthorityUtil {
    // 管理员标识
    private final static String ADMIN = "admin";
    // 储备粮标识
    private final static String CBL = "CBL";
    // 库点标识
    private final static String DC = "dc";

    // 用户代储点标识
    private final static String USER_BXTCJ = "本系统创建";


    // 获取仓房信息
    private static StorageStoreHouseService storageStoreHouseService;
    private static StorageWarehouseService  storageWarehouseService;
    static {
        storageStoreHouseService = (StorageStoreHouseService) AppUtil.getBean("storageStoreHouseService");
        //storageWarehouseService = (StorageWarehouseService) AppUtil.getBean("storageWarehouseService");
    }

    /**
     * 根据库点标识和用户信息获取当前用户拥有的最大数据权限
     *
     * @param kudianFlag 库点
     * @return 用户数据权限
     */
    public static String getDataAuthority(String kudianFlag) {
        // 当前用户信息
        SysUser user = TokenManager.getToken();
        // 管理员能查看所有库点
        if (ADMIN.equals(user.getAccount())) {
            return "";
        }

        // 获取库点代码
        List kudianCodes = storageStoreHouseService.listKudianCode();
        if (CBL.equals(user.getAccount()) || CBL.equals(user.getOriginCode())) {
            return "";
        }


        if (kudianCodes.contains(user.getOriginCode())) {
            if (DC.equals(kudianFlag)) {
                return "";
            }
        }

        if (USER_BXTCJ.equals(user.getNote())) {
            return user.getCompany();
        }

        return user.getOriginCode();
    }

    /*public static String getCurrentDataAuthority() {
        String warehouseCode = "";
        // 当前用户信息
        SysUser user = TokenManager.getToken();
        // 管理员能查看所有库点
        if (ADMIN.equals(user.getAccount())) {
            return "";
        }

        // 获取库点代码
        List kudianCodes = storageStoreHouseService.listKudianCode();
        if (CBL.equals(user.getAccount())) {
            //如果是公司人员，返回空
            return "";
        }


        if (kudianCodes.contains(user.getOriginCode())) {
            //如果是直属库人员，返回直属库代码
            warehouseCode =  user.getOriginCode();
            return warehouseCode;
        }

        if (USER_BXTCJ.equals(user.getNote())) {
            //如果是代储点，返回代储点所在公司的所有库代码
            //根据公司名获取库点
            HashMap<String,String> map = new HashMap<String,String>();
            map.put("enterpriseName", user.getCompany());
            List<StorageWarehouse> storageWarehouseList = storageWarehouseService.selectWareHouseByEnterPriseName(map);
            List<String> list = new ArrayList<String>();
            for (StorageWarehouse storageWarehouse:storageWarehouseList) {
                list.add(storageWarehouse.getWarehouseCode());
            }
             warehouseCode = StringUtils.join(list, ",");
            return warehouseCode;
        }

        return warehouseCode;
    }*/

}
