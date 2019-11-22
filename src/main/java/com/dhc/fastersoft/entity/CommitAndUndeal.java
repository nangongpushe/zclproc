package com.dhc.fastersoft.entity;

import java.math.BigDecimal;

public class CommitAndUndeal {
    private BigDecimal commitBidNum;//已提交的子bid数量
    private BigDecimal dealNum;//子方案成交数量
    private BigDecimal rotateNum;//子方案数量
    private String isEnd;//是否终结
    public BigDecimal getCommitBidNum() {
        return commitBidNum;
    }

    public void setCommitBidNum(BigDecimal commitBidNum) {
        this.commitBidNum = commitBidNum;
    }

    public BigDecimal getDealNum() {
        return dealNum;
    }

    public void setDealNum(BigDecimal dealNum) {
        this.dealNum = dealNum;
    }

    public BigDecimal getRotateNum() {
        return rotateNum;
    }

    public void setRotateNum(BigDecimal rotateNum) {
        this.rotateNum = rotateNum;
    }

    public String getIsEnd() {
        return isEnd;
    }

    public void setIsEnd(String isEnd) {
        this.isEnd = isEnd;
    }
}
