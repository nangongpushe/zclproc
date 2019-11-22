package com.dhc.fastersoft.test;

import cn.afterturn.easypoi.excel.ExcelExportUtil;
import cn.afterturn.easypoi.excel.entity.ExportParams;
import cn.afterturn.easypoi.excel.entity.params.ExcelExportEntity;
import org.apache.poi.ss.usermodel.Workbook;
import org.junit.Test;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RedisTest {

    @Test
    public void RedisDemo(){
        try {
            List<ExcelExportEntity> entity = new ArrayList<ExcelExportEntity>();
            entity.add(new ExcelExportEntity("姓名", "name"));
            entity.add(new ExcelExportEntity("性别", "sex"));

            //构造List等同于@ExcelCollection
            List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
            Map<String,Object> map = new HashMap<>();
            map.put("name","1111");
            map.put("sex","123");
            map.put("age",11);
            list.add(map);
            Map<String,Object> map1 = new HashMap<>();
            map1.put("name","1111");
            list.add(map1);

            Workbook workbook = ExcelExportUtil.exportExcel(new ExportParams("粮情检测记录统计", "测试"), entity,
                    list);
            FileOutputStream fos = new FileOutputStream("D:\\excel\\ExcelExportForMap.tt.xls");
            workbook.write(fos);
            fos.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void demo(){
        System.out.println(BigDecimal.ZERO);
    }

}
