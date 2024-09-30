package org.scoula.oauth.infra.oauth.naver.authcode;

import lombok.RequiredArgsConstructor;
import org.scoula.oauth.domain.authcode.AuthCodeRequestUrlProvider;
import org.scoula.oauth.domain.VO.OauthServerType;
import org.scoula.oauth.infra.oauth.naver.NaverOauthConfig;
import org.springframework.stereotype.Component;
import org.springframework.web.util.UriComponentsBuilder;

/*
 * Naver OAuth 인증 코드 요청 URI 제공
 */
@Component
@RequiredArgsConstructor
public class NaverAuthCodeRequestUrlProvider implements AuthCodeRequestUrlProvider {

    private final NaverOauthConfig naverOauthConfig;

    @Override
    public OauthServerType supportServer() {
        return OauthServerType.NAVER;
    }

    @Override
    public String provide() {
        return UriComponentsBuilder
                .fromUriString("https://nid.naver.com/oauth2.0/authorize")
                .queryParam("response_type", "code")
                .queryParam("client_id", naverOauthConfig.clientId())
                .queryParam("redirect_uri", naverOauthConfig.redirectUri())
                .queryParam("state", naverOauthConfig.state())
                .build()
                .toUriString();
    }
}
