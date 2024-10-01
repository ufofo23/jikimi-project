package org.scoula.oauth.infra.oauth.google;

import lombok.RequiredArgsConstructor;
import org.scoula.oauth.domain.vo.OauthMemberVO;
import org.scoula.oauth.domain.client.OauthMemberClient;
import org.scoula.oauth.domain.vo.OauthServerType;
import org.scoula.oauth.infra.oauth.google.client.GoogleApiClient;
import org.scoula.oauth.infra.oauth.google.dto.GoogleMemberResponse;
import org.scoula.oauth.infra.oauth.google.dto.GoogleToken;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

/*
 * Google OAuth 회원 정보 클라이언트
 */
@Component
@RequiredArgsConstructor
public class GoogleMemberClient implements OauthMemberClient {

    private final GoogleApiClient googleApiClient;
    private final GoogleOauthConfig googleOauthConfig;

    @Override
    public OauthServerType supportServer() {
        return OauthServerType.GOOGLE;
    }

    @Override
    public OauthMemberVO fetch(String authCode) {
        GoogleToken tokenInfo = googleApiClient.fetchToken(tokenRequestParams(authCode));

        // Access 토큰을 사용하여 Google 회원 정보를 가져옴
        GoogleMemberResponse googleMemberResponse =
                googleApiClient.fetchMember(tokenInfo.getAccessToken());

        return googleMemberResponse.toDomain();
    }

    private MultiValueMap<String, String> tokenRequestParams(String authCode) {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", googleOauthConfig.clientId());
        params.add("redirect_uri", googleOauthConfig.redirectUri());
        params.add("code", authCode);
        params.add("client_secret", googleOauthConfig.clientSecret());

        return params;
    }
}
