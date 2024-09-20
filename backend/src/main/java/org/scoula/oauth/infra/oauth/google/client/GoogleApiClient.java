package org.scoula.oauth.infra.oauth.google.client;

import org.scoula.oauth.infra.oauth.google.dto.GoogleMemberResponse;
import org.scoula.oauth.infra.oauth.google.dto.GoogleToken;
import org.springframework.util.MultiValueMap;

/*
 * Google API 클라이언트 인터페이스
 */
public interface GoogleApiClient {

    GoogleToken fetchToken(MultiValueMap<String, String> params);

    GoogleMemberResponse fetchMember(String bearerToken);
}
