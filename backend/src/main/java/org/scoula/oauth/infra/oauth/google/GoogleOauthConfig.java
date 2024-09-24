package org.scoula.oauth.infra.oauth.google;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

/*
 * Google OAuth 설정 정보 관리
 */
@Component
@PropertySource("classpath:application.properties")
public class GoogleOauthConfig {

    private final String redirectUri;
    private final String clientId;
    private final String clientSecret;
    private final String[] scope;

    @Autowired
    public GoogleOauthConfig(
            @Value("${oauth.google.redirect-uri}") String redirectUri,
            @Value("${oauth.google.client-id}") String clientId,
            @Value("${oauth.google.client-secret}") String clientSecret,
            @Value("${oauth.google.scope}") String[] scope) {
        this.redirectUri = redirectUri;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.scope = scope;
    }

    public String redirectUri() {
        return redirectUri;
    }

    public String clientId() {
        return clientId;
    }

    public String clientSecret() {
        return clientSecret;
    }

    public String[] scope() {
        return scope;
    }
}
