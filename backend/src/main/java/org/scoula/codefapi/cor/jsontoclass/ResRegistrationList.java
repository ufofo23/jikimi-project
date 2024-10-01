// ResRegistrationList.java

package org.scoula.codefapi.cor.jsontoclass;

import com.fasterxml.jackson.annotation.*;

public class ResRegistrationList {
    private String resType;
    private String resType1;
    private ResContentsList[] resContentsList;

    @JsonProperty("resType")
    public String getResType() { return resType; }
    @JsonProperty("resType")
    public void setResType(String value) { this.resType = value; }

    @JsonProperty("resType1")
    public String getResType1() { return resType1; }
    @JsonProperty("resType1")
    public void setResType1(String value) { this.resType1 = value; }

    @JsonProperty("resContentsList")
    public ResContentsList[] getResContentsList() { return resContentsList; }
    @JsonProperty("resContentsList")
    public void setResContentsList(ResContentsList[] value) { this.resContentsList = value; }
}