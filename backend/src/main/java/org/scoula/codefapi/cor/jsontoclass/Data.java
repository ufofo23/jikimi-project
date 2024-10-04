package org.scoula.codefapi.cor.jsontoclass;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Data {
    private ResRegisterEntriesList[] resRegisterEntriesList;
    private Object[] resSearchList;
    private Object[] resAddrList;
    private Object[] resImageList;
    private String resOriGinalData;
    private String resIssueYN;
    private String commIssueCode;
    private String resTotalPageCount;
    private String commStartPageNo;
    private String resEndPageNo;
    private String resWarningMessage;

    @JsonProperty("resRegisterEntriesList")
    public ResRegisterEntriesList[] getResRegisterEntriesList() { return resRegisterEntriesList; }
    @JsonProperty("resRegisterEntriesList")
    public void setResRegisterEntriesList(ResRegisterEntriesList[] value) { this.resRegisterEntriesList = value; }

    @JsonProperty("resSearchList")
    public Object[] getResSearchList() { return resSearchList; }
    @JsonProperty("resSearchList")
    public void setResSearchList(Object[] value) { this.resSearchList = value; }

    @JsonProperty("resAddrList")
    public Object[] getResAddrList() { return resAddrList; }
    @JsonProperty("resAddrList")
    public void setResAddrList(Object[] value) { this.resAddrList = value; }

    @JsonProperty("resImageList")
    public Object[] getResImageList() { return resImageList; }
    @JsonProperty("resImageList")
    public void setResImageList(Object[] value) { this.resImageList = value; }

    @JsonProperty("resOriGinalData")
    public String getResOriGinalData() { return resOriGinalData; }
    @JsonProperty("resOriGinalData")
    public void setResOriGinalData(String value) { this.resOriGinalData = value; }

    @JsonProperty("resIssueYN")
    public String getResIssueYN() { return resIssueYN; }
    @JsonProperty("resIssueYN")
    public void setResIssueYN(String value) { this.resIssueYN = value; }

    @JsonProperty("commIssueCode")
    public String getCommIssueCode() { return commIssueCode; }
    @JsonProperty("commIssueCode")
    public void setCommIssueCode(String value) { this.commIssueCode = value; }

    @JsonProperty("resTotalPageCount")
    public String getResTotalPageCount() { return resTotalPageCount; }
    @JsonProperty("resTotalPageCount")
    public void setResTotalPageCount(String value) { this.resTotalPageCount = value; }

    @JsonProperty("commStartPageNo")
    public String getCommStartPageNo() { return commStartPageNo; }
    @JsonProperty("commStartPageNo")
    public void setCommStartPageNo(String value) { this.commStartPageNo = value; }

    @JsonProperty("resEndPageNo")
    public String getResEndPageNo() { return resEndPageNo; }
    @JsonProperty("resEndPageNo")
    public void setResEndPageNo(String value) { this.resEndPageNo = value; }

    @JsonProperty("resWarningMessage")
    public String getResWarningMessage() { return resWarningMessage; }
    @JsonProperty("resWarningMessage")
    public void setResWarningMessage(String value) { this.resWarningMessage = value; }
}
