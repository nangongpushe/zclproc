package com.dhc.fastersoft.entity;

import cn.afterturn.easypoi.excel.annotation.Excel;

import java.math.BigDecimal;

public class ExportRotateSum {

    private String id;
    private String dealID;
    private String schemeID;
    @Excel(name="成交子明细号",needMerge = true)
    private String dealSerial;
    @Excel(name="成交单位",needMerge = true)
    private String dealUnit;
    private String bidSerial;
    private String receivePlace;
    @Excel(name="仓房编号",needMerge = true)
    private String storehouse;
    @Excel(name="交货所属库点",needMerge = true)
    private String deliveryPlace;
    @Excel(name="粮食品种",needMerge = true)
    private String grainType;
    @Excel(name="数量(吨)",needMerge = true)
    private String quantity;
    @Excel(name="产地",needMerge = true)
    private String produceArea;
    private String produceYear;
    @Excel(name="入库年度",needMerge = true)
    private String warehoueYear;
    @Excel(name="储存方式",needMerge = true)
    private String storageType;
    @Excel(name="成交价格(元/吨)",needMerge = true)
    private double dealPrice;
    @Excel(name="成交金额(元)",needMerge = true)
    private double dealAmount;
    @Excel(name="提货截止时间",needMerge = true)
    private String takeEnd;
    private String deliveryStart;
    private String deliveryEnd;
    private String dealDate;
    private String inviteType;
    private String schemeName;

    private String warehouseId;
    private String inviteDetailId;

    /**
     * 所属公司
     */
    private String enterpriseName;
    private String enterpriseId;


    /**
     * 货款支付免息截止日期
     */
    private String loanPaymentEndDate;
    /*在提货截至日期后面新增：已付金额（货款已认领），
    未付货款金额（成交金额-已付货款金额），
    已开提货单数量（对应的交易明细号已开提货单的总数量），
    剩余未开数量（成交总数量-已开提货单数量），
    占用保证金（招标结果里的数据），
    保证金余额（占用保证金-保证金退还金额）。*/
    /*已付货款金额*/
    @Excel(name="已付金额(货款)",needMerge = true)
    private BigDecimal payedMoney;
    /*未付金额*/
    @Excel(name="未付金额(货款)",needMerge = true)
    private BigDecimal unPayMoney;
    /*已开提货单数量*/
    @Excel(name="已开提货单数量",needMerge = true)
    private BigDecimal takedOrderNum;
    /*剩余未开数量*/
    @Excel(name="剩余未开数量",needMerge = true)
    private BigDecimal unTakeOrderNum;
    /*占用保证金*/
    @Excel(name="占用保证金",needMerge = true)
    private BigDecimal totalBail;
    /*返还保证金*/
    private BigDecimal reTotalBail;
    /*保证金余额*/
    @Excel(name="保证金余额",needMerge = true)
    private BigDecimal restbail;
    /*商务处理类型金额*/
    private BigDecimal type00;//已认领
    private BigDecimal type01;//总商务金额

    private BigDecimal type10;//已认领
    private BigDecimal type11;//总商务金额

    private BigDecimal type20;//已认领
    private BigDecimal type21;//总商务金额

    private BigDecimal type30;//已认领
    private BigDecimal type31;//总商务金额

    private BigDecimal type40;//已认领
    private BigDecimal type41;//总商务金额

    private BigDecimal type50;//已认领
    private BigDecimal type51;//总商务金额

    public BigDecimal getRestbail() {
        return totalBail.subtract(reTotalBail);
        //return restbail;
    }

    public void setRestbail(BigDecimal restbail) {
        this.restbail = totalBail.subtract(reTotalBail);
        //this.restbail = restbail;
    }

    public String getLoanPaymentEndDate() {
        return loanPaymentEndDate;
    }

    public void setLoanPaymentEndDate(String loanPaymentEndDate) {
        this.loanPaymentEndDate = loanPaymentEndDate;
    }
    /**
     * 交货所属库点Id
     */
    private String deliveryId;
    /**
     * 收货所属库点Id
     */
    private String receiveId;


    private double compleRate;
    private String schemeBatch;
    private String startTime;
    private String endTime;
    private String biddingTime;
    private String claimAmount;

    /**
     * 招标名称
     */
    private String inviteName;
    /**
     * 招标明细保证金
     */
    private String bail;
    /**
     * 招标结果ID
     */
    private String inviteId;
    /**
     * 剩余退还保证金
     */
    private BigDecimal surplusBail;

    public BigDecimal getSurplusBail() {
        return surplusBail;
    }

    public void setSurplusBail(BigDecimal surplusBail) {
        this.surplusBail = surplusBail;
    }

    public String getInviteName() {
        return inviteName;
    }

    public void setInviteName(String inviteName) {
        this.inviteName = inviteName;
    }

    public String getBail() {
        return bail;
    }

    public void setBail(String bail) {
        this.bail = bail;
    }

    public String getInviteId() {
        return inviteId;
    }

    public void setInviteId(String inviteId) {
        this.inviteId = inviteId;
    }

    public String getDealDate() {
        return dealDate;
    }
    public void setDealDate(String dealDate) {
        this.dealDate = dealDate;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getDealID() {
        return dealID;
    }
    public void setDealID(String dealID) {
        this.dealID = dealID;
    }
    public String getSchemeID() {
        return schemeID;
    }
    public void setSchemeID(String schemeID) {
        this.schemeID = schemeID;
    }

    public String getDealSerial() {
        return dealSerial;
    }
    public void setDealSerial(String dealSerial) {
        this.dealSerial = dealSerial;
    }
    public String getBidSerial() {
        return bidSerial;
    }
    public void setBidSerial(String bidSerial) {
        this.bidSerial = bidSerial;
    }
    public String getDeliveryPlace() {
        return deliveryPlace;
    }
    public void setDeliveryPlace(String deliveryPlace) {
        this.deliveryPlace = deliveryPlace;
    }
    public String getReceivePlace() {
        return receivePlace;
    }
    public void setReceivePlace(String receivePlace) {
        this.receivePlace = receivePlace;
    }
    public String getStorehouse() {
        return storehouse;
    }
    public void setStorehouse(String storehouse) {
        this.storehouse = storehouse;
    }
    public String getGrainType() {
        return grainType;
    }
    public void setGrainType(String grainType) {
        this.grainType = grainType;
    }
    public String getQuantity() {
        return quantity;
    }
    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }
    public String getProduceArea() {
        return produceArea;
    }
    public void setProduceArea(String produceArea) {
        this.produceArea = produceArea;
    }
    public String getProduceYear() {
        return produceYear;
    }
    public void setProduceYear(String produceYear) {
        this.produceYear = produceYear;
    }
    public String getWarehoueYear() {
        return warehoueYear;
    }
    public void setWarehoueYear(String warehoueYear) {
        this.warehoueYear = warehoueYear;
    }
    public String getStorageType() {
        return storageType;
    }
    public void setStorageType(String storageType) {
        this.storageType = storageType;
    }


    public double getDealPrice() {
        return dealPrice;
    }
    public void setDealPrice(double dealPrice) {
        this.dealPrice = dealPrice;
    }
    public double getDealAmount() {
        return dealAmount;
    }
    public void setDealAmount(double dealAmount) {
        this.dealAmount = dealAmount;
    }
    public String getTakeEnd() {
        return takeEnd;
    }
    public void setTakeEnd(String takeEnd) {
        this.takeEnd = takeEnd;
    }
    public String getDeliveryStart() {
        return deliveryStart;
    }
    public void setDeliveryStart(String deliveryStart) {
        this.deliveryStart = deliveryStart;
    }
    public String getDeliveryEnd() {
        return deliveryEnd;
    }
    public void setDeliveryEnd(String deliveryEnd) {
        this.deliveryEnd = deliveryEnd;
    }
    public String getDealUnit() {
        return dealUnit;
    }
    public void setDealUnit(String dealUnit) {
        this.dealUnit = dealUnit;
    }
    public String getInviteType() {
        return inviteType;
    }
    public void setInviteType(String inviteType) {
        this.inviteType = inviteType;
    }
    public String getSchemeName() {
        return schemeName;
    }
    public void setSchemeName(String schemeName) {
        this.schemeName = schemeName;
    }

    public double getCompleRate() {
        return compleRate;
    }

    public void setCompleRate(double compleRate) {
        this.compleRate = compleRate;
    }

    public String getSchemeBatch() {
        return schemeBatch;
    }

    public void setSchemeBatch(String schemeBatch) {
        this.schemeBatch = schemeBatch;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getBiddingTime() {
        return biddingTime;
    }

    public void setBiddingTime(String biddingTime) {
        this.biddingTime = biddingTime;
    }

    public String getDeliveryId() {
        return deliveryId;
    }

    public void setDeliveryId(String deliveryId) {
        this.deliveryId = deliveryId;
    }

    public String getReceiveId() {
        return receiveId;
    }

    public void setReceiveId(String receiveId) {
        this.receiveId = receiveId;
    }

    public String getClaimAmount() {
        return claimAmount;
    }

    public void setClaimAmount(String claimAmount) {
        this.claimAmount = claimAmount;
    }

    public String getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(String warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getInviteDetailId() {
        return inviteDetailId;
    }

    public void setInviteDetailId(String inviteDetailId) {
        this.inviteDetailId = inviteDetailId;
    }

    public String getEnterpriseName() {
        return enterpriseName;
    }

    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName;
    }

    public String getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(String enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

    public BigDecimal getPayedMoney() {
        return payedMoney;
    }

    public void setPayedMoney(BigDecimal payedMoney) {
        this.payedMoney = payedMoney;
    }

    public BigDecimal getUnPayMoney() {
        return new BigDecimal(dealAmount).subtract(payedMoney);
        //return unPayMoney;
    }

    public void setUnPayMoney(BigDecimal unPayMoney) {

        //this.unPayMoney = unPayMoney;
        this.unPayMoney = new BigDecimal(dealAmount).subtract(payedMoney);
    }

    public BigDecimal getTakedOrderNum() {
        return takedOrderNum;
    }

    public void setTakedOrderNum(BigDecimal takedOrderNum) {
        this.takedOrderNum = takedOrderNum;
    }

    public BigDecimal getUnTakeOrderNum() {
        if(quantity == null){
            quantity = "0";
        }
        return new BigDecimal(quantity).subtract(takedOrderNum);
        //return unTakeOrderNum ;
    }

    public void setUnTakeOrderNum(BigDecimal unTakeOrderNum) {
        if(quantity == null){
            quantity = "0";
        }
        this.unTakeOrderNum = new BigDecimal(quantity).subtract(takedOrderNum);
        //this.unTakeOrderNum = unTakeOrderNum;
    }

    public BigDecimal getTotalBail() {
        return totalBail;
    }

    public void setTotalBail(BigDecimal totalBail) {
        this.totalBail = totalBail;
    }

    public BigDecimal getReTotalBail() {
        return reTotalBail;
    }

    public void setReTotalBail(BigDecimal reTotalBail) {
        this.reTotalBail = reTotalBail;
    }

    public BigDecimal getType00() {
        return type00;
    }

    public void setType00(BigDecimal type00) {
        this.type00 = type00;
    }

    public BigDecimal getType01() {
        return type01;
    }

    public void setType01(BigDecimal type01) {
        this.type01 = type01;
    }

    public BigDecimal getType10() {
        return type10;
    }

    public void setType10(BigDecimal type10) {
        this.type10 = type10;
    }

    public BigDecimal getType11() {
        return type11;
    }

    public void setType11(BigDecimal type11) {
        this.type11 = type11;
    }

    public BigDecimal getType20() {
        return type20;
    }

    public void setType20(BigDecimal type20) {
        this.type20 = type20;
    }

    public BigDecimal getType21() {
        return type21;
    }

    public void setType21(BigDecimal type21) {
        this.type21 = type21;
    }

    public BigDecimal getType30() {
        return type30;
    }

    public void setType30(BigDecimal type30) {
        this.type30 = type30;
    }

    public BigDecimal getType31() {
        return type31;
    }

    public void setType31(BigDecimal type31) {
        this.type31 = type31;
    }

    public BigDecimal getType40() {
        return type40;
    }

    public void setType40(BigDecimal type40) {
        this.type40 = type40;
    }

    public BigDecimal getType41() {
        return type41;
    }

    public void setType41(BigDecimal type41) {
        this.type41 = type41;
    }

    public BigDecimal getType50() {
        return type50;
    }

    public void setType50(BigDecimal type50) {
        this.type50 = type50;
    }

    public BigDecimal getType51() {
        return type51;
    }

    public void setType51(BigDecimal type51) {
        this.type51 = type51;
    }
}
