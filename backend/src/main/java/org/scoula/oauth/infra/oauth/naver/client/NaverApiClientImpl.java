package org.scoula.oauth.infra.oauth.naver.client;

import org.scoula.oauth.infra.oauth.naver.dto.NaverMemberResponse;
import org.scoula.oauth.infra.oauth.naver.dto.NaverToken;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

/*
 * Naver API 클라이언트 구현
 */
@Component
public class NaverApiClientImpl implements NaverApiClient {

    private final RestTemplate restTemplate;
    private static final String TOKEN_URL = "https://nid.naver.com/oauth2.0/token";
    private static final String MEMBER_URL = "https://openapi.naver.com/v1/nid/me";

    public NaverApiClientImpl(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @Override
    public NaverToken fetchToken(MultiValueMap<String, String> params) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

        try {
            ResponseEntity<NaverToken> response = restTemplate.exchange(
                    TOKEN_URL,
                    HttpMethod.POST,
                    request,
                    NaverToken.class
            );

            return response.getBody();
        } catch (HttpClientErrorException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public NaverMemberResponse fetchMember(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);

        HttpEntity<Void> requestEntity = new HttpEntity<>(headers);

        try {
            ResponseEntity<NaverMemberResponse> response = restTemplate.exchange(
                    MEMBER_URL,
                    HttpMethod.GET,
                    requestEntity,
                    NaverMemberResponse.class
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
