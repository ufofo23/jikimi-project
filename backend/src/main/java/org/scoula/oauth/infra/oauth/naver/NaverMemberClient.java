package org.scoula.oauth.infra.oauth.naver;

import lombok.RequiredArgsConstructor;
import org.scoula.oauth.domain.vo.OauthMemberVO;
import org.scoula.oauth.domain.client.OauthMemberClient;
import org.scoula.oauth.domain.vo.OauthServerType;
import org.scoula.oauth.infra.oauth.naver.client.NaverApiClient;
import org.scoula.oauth.infra.oauth.naver.dto.NaverMemberResponse;
import org.scoula.oauth.infra.oauth.naver.dto.NaverToken;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

/*
 * Naver API 클라이언트를 통한 회원 정보 조회 구현
 */
@Component
@RequiredArgsConstructor
public class NaverMemberClient implements OauthMemberClient {

    private final NaverApiClient naverApiClient;
    private final NaverOauthConfig naverOauthConfig;

    @Override
    public OauthServerType supportServer() {
        return OauthServerType.NAVER;
    }

    @Override
    public OauthMemberVO fetch(String authCode) {
        NaverToken tokenInfo = naverApiClient.fetchToken(tokenRequestParams(authCode));
        NaverMemberResponse naverMemberResponse = naverApiClient.fetchMember(tokenInfo.getAccessToken());
        return naverMemberResponse.toDomain();
    }

    private MultiValueMap<String, String> tokenRequestParams(String authCode) {
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", naverOauthConfig.clientId());
        params.add("client_secret", naverOauthConfig.clientSecret());
        params.add("code", authCode);
        params.add("state", naverOauthConfig.state());
        return params;
    }
}
