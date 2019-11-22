package com.dhc.fastersoft.entity.system;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class SysUser implements Serializable{
	
	private static final long serialVersionUID = 1L;
	//0:禁止登录
	public static final Long _0 = new Long(0);
	//1:有效
	public static final Long _1 = new Long(1);
	
    private String id;

    private String account;

    private String name;

    private String password;

    private String salt;

    private String createTime;
    
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date lastLoginTime;

    private BigDecimal status;
    
    private String note;

    private String company;	//全称

    private String department;

    private String position;

    private String cellPhone;

    private String email;

    private String avatar;
    
    private String signature;
    
    private String originCode;	//库点编码
    
    private String shortName;    //库名
	private String wareHouseId;    //库名id
	private String enterPriseId;    //库名id
	private String isEdit;    //是否可以修改

	public String getEnterPriseId() {
		return enterPriseId;
	}

	public void setEnterPriseId(String enterPriseId) {
		this.enterPriseId = enterPriseId;
	}

	public String getIsEdit() {
		return isEdit;
	}

	public void setIsEdit(String isEdit) {
		this.isEdit = isEdit;
	}

	public String getWareHouseId() {
		return wareHouseId;
	}

	public void setWareHouseId(String wareHouseId) {
		this.wareHouseId = wareHouseId;
	}

	public String getShortName() {
		return shortName;
	}

	public void setShortName(String shortName) {
		this.shortName = shortName;
	}

	public String getOriginCode() {
		return originCode;
	}

	public void setOriginCode(String originCode) {
		this.originCode = originCode;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account == null ? null : account.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt == null ? null : salt.trim();
    }

    public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public Date getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(Date lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    public BigDecimal getStatus() {
        return status;
    }

    public void setStatus(BigDecimal status) {
        this.status = status;
    }
    
    public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	
	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public SysUser() {
		// TODO Auto-generated constructor stub
	}
    public SysUser(SysUser sysUser) {
		this.id = sysUser.getId();
		this.name = sysUser.getName();
		this.account = sysUser.getAccount();
		this.password = sysUser.getPassword();
		this.createTime = sysUser.getCreateTime();
		this.lastLoginTime = sysUser.getLastLoginTime();
		this.note = sysUser.getNote();
        this.company = sysUser.getCompany();
        this.department = sysUser.getDepartment();
        this.position = sysUser.getPosition();
        this.cellPhone = sysUser.getCellPhone();
        this.email = sysUser.getEmail();
        this.avatar = sysUser.getAvatar();
        this.signature = sysUser.getSignature();
	}

	@Override
	public String toString() {
		return "SysUser{" +
				"id='" + id + '\'' +
				", account='" + account + '\'' +
				", name='" + name + '\'' +
				", password='" + password + '\'' +
				", salt='" + salt + '\'' +
				", createTime='" + createTime + '\'' +
				", lastLoginTime=" + lastLoginTime +
				", status=" + status +
				", note='" + note + '\'' +
				", company='" + company + '\'' +
				", department='" + department + '\'' +
				", position='" + position + '\'' +
				", cellPhone='" + cellPhone + '\'' +
				", email='" + email + '\'' +
				", avatar='" + avatar + '\'' +
				", signature='" + signature + '\'' +
				", originCode='" + originCode + '\'' +
				", shortName='" + shortName + '\'' +
				", wareHouseId='" + wareHouseId + '\'' +
				", enterPriseId='" + enterPriseId + '\'' +
				", isEdit='" + isEdit + '\'' +
				'}';
	}
}