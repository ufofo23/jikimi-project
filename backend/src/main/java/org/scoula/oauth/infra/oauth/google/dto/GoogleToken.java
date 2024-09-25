package org.scoula.oauth.infra.oauth.google.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
public class GoogleToken {
    private String tokenType;
    private String accessToken;
    private Integer expiresIn;
    private String refreshToken;
    private String scope;
    private String idToken;
}