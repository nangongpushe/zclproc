package com.dhc.fastersoft.entity;


import java.util.Date;

public class DurablesOptions {
    private String id;   //主键ID';

    private String durablesId;   // '非易耗品ID';

    private String optionName;   //'名称';

    private String optionModel;   //'规格/型号';

    private int optionNum;    //'数量';

    private String optionPlace;   //'存放地点';

    private String creator;     //'创建人';

    private String createDate;    //'创建时间';

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

    public String getOptionName() {
        return optionName;
    }

    public void setOptionName(String optionName) {
        this.optionName = optionName;
    }

    public String getOptionModel() {
        return optionModel;
    }

    public void setOptionModel(String optionModel) {
        this.optionModel = optionModel;
    }

    public int getOptionNum() {
        return optionNum;
    }

    public void setOptionNum(int optionNum) {
        this.optionNum = optionNum;
    }

    public String getOptionPlace() {
        return optionPlace;
    }

    public void setOptionPlace(String optionPlace) {
        this.optionPlace = optionPlace;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }
}