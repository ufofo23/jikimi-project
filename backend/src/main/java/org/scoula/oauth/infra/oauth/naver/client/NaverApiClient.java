package org.scoula.oauth.infra.oauth.naver.client;

import org.scoula.oauth.infra.oauth.naver.dto.NaverMemberResponse;
import org.scoula.oauth.infra.oauth.naver.dto.NaverToken;
import org.springframework.util.MultiValueMap;

/*
 * Naver API 클라이언트 인터페이스
 */
public interface NaverApiClient {

    NaverToken fetchToken(MultiValueMap<String, String> params);

    NaverMemberResponse fetchMember(String bearerToken);
}
