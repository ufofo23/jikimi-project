package org.scoula.oauth.infra.oauth.google.client;

import org.scoula.oauth.infra.oauth.google.dto.GoogleMemberResponse;
import org.scoula.oauth.infra.oauth.google.dto.GoogleToken;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

/*
 * Google API 클라이언트 구현체
 */
@Component
public class GoogleApiClientImpl implements GoogleApiClient {

    private final RestTemplate restTemplate;

    private static final String TOKEN_URL = "https://oauth2.googleapis.com/token";

    private static final String MEMBER_URL = "https://www.googleapis.com/userinfo/v2/me";

    public GoogleApiClientImpl(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    // 토큰 정보 가져오기
    @Override
    public GoogleToken fetchToken(MultiValueMap<String, String> params) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

        try {
            ResponseEntity<GoogleToken> response = restTemplate.exchange(
                    TOKEN_URL,
                    HttpMethod.POST,
                    request,
                    GoogleToken.class
            );
            return response.getBody();
        } catch (HttpClientErrorException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Access 토큰으로 사용자 정보 가져오기
    @Override
    public GoogleMemberResponse fetchMember(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);

        HttpEntity<Void> requestEntity = new HttpEntity<>(headers);

        try {
            ResponseEntity<GoogleMemberResponse> response = restTemplate.exchange(
                    MEMBER_URL,
                    HttpMethod.GET,
                    requestEntity,
                    GoogleMemberResponse.class
            );

            return response.getBody();
        } catch (HttpClientErrorException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
