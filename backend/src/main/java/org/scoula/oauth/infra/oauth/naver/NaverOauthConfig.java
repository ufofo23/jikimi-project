package org.scoula.oauth.infra.oauth.naver;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

/*
 * Naver OAuth 설정 정보 클래스
 */
@Component
@PropertySource("classpath:application.properties")
public class NaverOauthConfig {
    private final String redirectUri;
    private final String clientId;
    private final String clientSecret;
    private final String[] scope;
    private final String state;

    @Autowired
    public NaverOauthConfig(
            @Value("${oauth.naver.redirect-uri}") String redirectUri,
            @Value("${oauth.naver.client-id}") String clientId,
            @Value("${oauth.naver.client-secret}") String clientSecret,
            @Value("${oauth.naver.scope}") String[] scope,
            @Value("${oauth.naver.state}") String state
    ) {
        this.redirectUri = redirectUri;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.scope = scope;
        this.state = state;
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

    public String state() {
        return state;
    }
}
