package com.dhc.fastersoft.entity;

import java.util.Date;

public class DurablesMaintain {
   
    private String id;  //主键ID

    private String durablesId;   // '非易耗品ID'
  
    private String encode;  //物资编码
 
    private String type;  //类型:药剂类、物资、麻袋
  
    private String commodity;   //品名
  
    private String maintainDate;  //维修日期
   
    private String maintainMan;  //维修保养人员
  
    private String maintainContent; //维修内容
    
    private String remark; //备注

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDurablesId() {
		return durablesId;
	}

	public void setDurablesId(String durablesId) {
		this.durablesId = durablesId;
	}

	public String getEncode() {
		return encode;
	}

	public void setEncode(String encode) {
		this.encode = encode;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCommodity() {
		return commodity;
	}

	public void setCommodity(String commodity) {
		this.commodity = commodity;
	}

	public String getMaintainDate() {
		return maintainDate;
	}

	public void setMaintainDate(String maintainDate) {
		this.maintainDate = maintainDate;
	}

	public String getMaintainMan() {
		return maintainMan;
	}

	public void setMaintainMan(String maintainMan) {
		this.maintainMan = maintainMan;
	}

	public String getMaintainContent() {
		return maintainContent;
	}

	public void setMaintainContent(String maintainContent) {
		this.maintainContent = maintainContent;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
    
}

   