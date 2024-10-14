package org.scoula.naver_api.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.scoula.naver_api.dto.BlogResponseDto;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Collections;


@Service
public class BlogService {
    @Value("${oauth.naver.client-id}")
    private String clientId;
    @Value("${oauth.naver.client-secret}")
    private String clientSecret;
    private static final String NAVER_BLOG_API_UTI = "https://openapi.naver.com/v1/search/blog.json";

    public BlogResponseDto searchNews(String query, int display, int start){
        RestTemplate restTemplate = new RestTemplate();
//        String encodedQuery = URLEncoder.encode("전세사기유형", StandardCharsets.UTF_8.toString());
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Naver-Client-Id", clientId);
        headers.set("X-Naver-Client-Secret", clientSecret);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        // 이 방식으로 왜 안되는지 나중에 알아보기
//        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(NAVER_BLOG_API_UTI)
//                .queryParam("query", encodedQuery)
//                .queryParam("display", display)
//                .queryParam("start", start);
        String url = NAVER_BLOG_API_UTI+"?query="+query+"&display="+display+"&start="+start;

        HttpEntity<?> entity = new HttpEntity<>(headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    url,
                    HttpMethod.GET,
                    entity,
                    String.class);

            ObjectMapper objectMapper = new ObjectMapper();
            BlogResponseDto blogResponseDto = objectMapper.readValue(response.getBody(), BlogResponseDto.class);

            return blogResponseDto;

        } catch (Exception e) {
            throw new RuntimeException("뉴스 패치 실패", e);
        }
    }
}