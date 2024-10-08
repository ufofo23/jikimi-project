package org.scoula.safety_inspection.infra.cors.jsontoclass;

import com.fasterxml.jackson.annotation.JsonProperty;

public class O {
    private Result result;
    private Data data;

    @JsonProperty("result")
    public Result getResult() { return result; }
    @JsonProperty("result")
    public void setResult(Result value) { this.result = value; }

    @JsonProperty("data")
    public Data getData() { return data; }
    @JsonProperty("data")
    public void setData(Data value) { this.data = value; }
}
