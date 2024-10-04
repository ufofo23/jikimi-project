package org.scoula.codefapi.cor.jsontoclass;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ResRegisterEntriesList {
    private String resDocTitle;
    private String resRealty;
    private String commUniqueNo;
    private ResRegistrationList[] resRegistrationHisList;
    private String commCompetentRegistryOffice;
    private String resPublishNo;
    private String resIssueNo;
    private String resPublishDate;
    private String resPublishRegistryOffice;
    private ResRegistrationList[] resRegistrationSumList;
    private Object[] resPrecautionsList;

    @JsonProperty("resDocTitle")
    public String getResDocTitle() { return resDocTitle; }
    @JsonProperty("resDocTitle")
    public void setResDocTitle(String value) { this.resDocTitle = value; }

    @JsonProperty("resRealty")
    public String getResRealty() { return resRealty; }
    @JsonProperty("resRealty")
    public void setResRealty(String value) { this.resRealty = value; }

    @JsonProperty("commUniqueNo")
    public String getCommUniqueNo() { return commUniqueNo; }
    @JsonProperty("commUniqueNo")
    public void setCommUniqueNo(String value) { this.commUniqueNo = value; }

    @JsonProperty("resRegistrationHisList")
    public ResRegistrationList[] getResRegistrationHisList() { return resRegistrationHisList; }
    @JsonProperty("resRegistrationHisList")
    public void setResRegistrationHisList(ResRegistrationList[] value) { this.resRegistrationHisList = value; }

    @JsonProperty("commCompetentRegistryOffice")
    public String getCommCompetentRegistryOffice() { return commCompetentRegistryOffice; }
    @JsonProperty("commCompetentRegistryOffice")
    public void setCommCompetentRegistryOffice(String value) { this.commCompetentRegistryOffice = value; }

    @JsonProperty("resPublishNo")
    public String getResPublishNo() { return resPublishNo; }
    @JsonProperty("resPublishNo")
    public void setResPublishNo(String value) { this.resPublishNo = value; }

    @JsonProperty("resIssueNo")
    public String getResIssueNo() { return resIssueNo; }
    @JsonProperty("resIssueNo")
    public void setResIssueNo(String value) { this.resIssueNo = value; }

    @JsonProperty("resPublishDate")
    public String getResPublishDate() { return resPublishDate; }
    @JsonProperty("resPublishDate")
    public void setResPublishDate(String value) { this.resPublishDate = value; }

    @JsonProperty("resPublishRegistryOffice")
    public String getResPublishRegistryOffice() { return resPublishRegistryOffice; }
    @JsonProperty("resPublishRegistryOffice")
    public void setResPublishRegistryOffice(String value) { this.resPublishRegistryOffice = value; }

    @JsonProperty("resRegistrationSumList")
    public ResRegistrationList[] getResRegistrationSumList() { return resRegistrationSumList; }
    @JsonProperty("resRegistrationSumList")
    public void setResRegistrationSumList(ResRegistrationList[] value) { this.resRegistrationSumList = value; }

    @JsonProperty("resPrecautionsList")
    public Object[] getResPrecautionsList() { return resPrecautionsList; }
    @JsonProperty("resPrecautionsList")
    public void setResPrecautionsList(Object[] value) { this.resPrecautionsList = value; }
}
