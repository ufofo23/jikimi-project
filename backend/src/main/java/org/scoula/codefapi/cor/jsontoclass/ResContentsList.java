package org.scoula.codefapi.cor.jsontoclass;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ResContentsList {
    private String resNumber;
    private String resType2;
    private ResDetailList[] resDetailList;

    @JsonProperty("resNumber")
    public String getResNumber() { return resNumber; }
    @JsonProperty("resNumber")
    public void setResNumber(String value) { this.resNumber = value; }

    @JsonProperty("resType2")
    public String getResType2() { return resType2; }
    @JsonProperty("resType2")
    public void setResType2(String value) { this.resType2 = value; }

    @JsonProperty("resDetailList")
    public ResDetailList[] getResDetailList() { return resDetailList; }
    @JsonProperty("resDetailList")
    public void setResDetailList(ResDetailList[] value) { this.resDetailList = value; }
}
