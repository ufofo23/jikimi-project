package org.scoula.oauth.infra.oauth.google.authcode;

import lombok.RequiredArgsConstructor;
import org.scoula.oauth.domain.authcode.AuthCodeRequestUrlProvider;
import org.scoula.oauth.domain.VO.OauthServerType;
import org.scoula.oauth.infra.oauth.google.GoogleOauthConfig;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

/*
 * Google OAuth 인증 코드 요청 URI 제공
 */
@Component
@RequiredArgsConstructor
public class GoogleAuthCodeRequestUriProvider implements AuthCodeRequestUrlProvider {

    private final GoogleOauthConfig googleOauthConfig;

    @Override
    public OauthServerType supportServer() {
        return OauthServerType.GOOGLE;
    }

    @Override
    public String provide() {
        return UriComponentsBuilder
                .fromUriString("https://accounts.google.com/o/oauth2/v2/auth")
                .queryParam("response_type", "code")
                .queryParam("client_id", googleOauthConfig.clientId())
                .queryParam("redirect_uri", googleOauthConfig.redirectUri())
                .queryParam("scope", String.join(",", googleOauthConfig.scope()))
                .toUriString();
    }
}
