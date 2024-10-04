package org.scoula.codefapi.cor.jsontoclass;

import com.fasterxml.jackson.annotation.JsonProperty;

public class Result {
    private String code;
    private String extraMessage;
    private String message;
    private String transactionID;

    @JsonProperty("code")
    public String getCode() { return code; }
    @JsonProperty("code")
    public void setCode(String value) { this.code = value; }

    @JsonProperty("extraMessage")
    public String getExtraMessage() { return extraMessage; }
    @JsonProperty("extraMessage")
    public void setExtraMessage(String value) { this.extraMessage = value; }

    @JsonProperty("message")
    public String getMessage() { return message; }
    @JsonProperty("message")
    public void setMessage(String value) { this.message = value; }

    @JsonProperty("transactionId")
    public String getTransactionID() { return transactionID; }
    @JsonProperty("transactionId")
    public void setTransactionID(String value) { this.transactionID = value; }
}
