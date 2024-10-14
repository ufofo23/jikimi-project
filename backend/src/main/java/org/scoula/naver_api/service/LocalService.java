package org.scoula.naver_api.service;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.log4j.Log4j;
import org.scoula.naver_api.dto.ImageResponseDto;
import org.scoula.naver_api.dto.LocalResponseDto;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;

@Log4j
@Service
public class LocalService {
    @Value("${oauth.naver.client-id}")
    private String clientId;
    @Value("${oauth.naver.client-secret}")
    private String clientSecret;
    private static final String NAVER_LOCAL_API_UTI = "https://openapi.naver.com/v1/search/local.json";

    public LocalResponseDto searchLocal(String query, int display, int start, String sort){
//        log.info("searchLocal:::::::::::::::::::");
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Naver-Client-Id", clientId);
        headers.set("X-Naver-Client-Secret", clientSecret);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        String url = NAVER_LOCAL_API_UTI+"?query="+query+"&display="+display+"&start="+start+"&sort="+sort;

        HttpEntity<?> entity = new HttpEntity<>(headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    url,
                    HttpMethod.GET,
                    entity,
                    String.class);

//            log.info("LocalResponse"+response.getBody());
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
            LocalResponseDto localResponseDto = objectMapper.readValue(response.getBody(), LocalResponseDto.class);

            return localResponseDto;

        } catch (Exception e) {
            throw new RuntimeException("지역정보 패치 실패", e);
        }
    }
}