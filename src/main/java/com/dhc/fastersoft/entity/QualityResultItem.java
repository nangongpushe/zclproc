package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

import java.math.BigDecimal;

public class QualityResultItem {
    private String id;

    private String resultId;
    @Excel(name="检测项名称")
    private String itemName;
    @Excel(name="等级")
    private String grade;
    @Excel(name="标准值")
    private String standard;
    @Excel(name="检测值")
    private String result;
    @Excel(name="结论")
    private String remark;
    
    private String repetition;
    
    private String count;
    private BigDecimal orderNo;

    public BigDecimal getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(BigDecimal orderNo) {
        this.orderNo = orderNo;
    }
    public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getRepetition() {
		return repetition;
	}

	public void setRepetition(String repetition) {
		this.repetition = repetition;
	}

    public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	private String one;
    private String two;
    private String sum;
    public String getSum() {
		return sum;
	}

    public void setSum(String sum) {
		this.sum = sum;
	}

	public String getOne() {
		return one;
	}

	public void setOne(String one) {
		this.one = one;
	}

	public String getTwo() {
		return two;
	}

	public void setTwo(String two) {
		this.two = two;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id == null ? null : id.trim();
    }

    public String getResultId() {
        return resultId;
    }

    public void setResultId(String resultId) {
        this.resultId = resultId == null ? null : resultId.trim();
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName == null ? null : itemName.trim();
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade == null ? null : grade.trim();
    }

    public String getStandard() {
        return standard;
    }

    public void setStandard(String standard) {
        this.standard = standard == null ? null : standard.trim();
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result == null ? null : result.trim();
    }
    
    public QualityResultItem(String itemName) {
		this.itemName = itemName;
	}

	public QualityResultItem() {
	}
    
    @Override
	public boolean equals(Object obj) {
		QualityResultItem target = (QualityResultItem)obj;
		return this.itemName.equals(target.getItemName());
	}
}