package org.scoula.naver_api.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.log4j.Log4j;
import org.scoula.naver_api.dto.BlogResponseDto;
import org.scoula.naver_api.dto.ImageResponseDto;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.awt.*;
import java.io.UnsupportedEncodingException;
import java.util.Base64;
import java.util.Collections;


@Log4j
@Service
public class ImageService {
    @Value("${oauth.naver.client-id}")
    private String clientId;
    @Value("${oauth.naver.client-secret}")
    private String clientSecret;
    private static final String NAVER_IMAGE_API_UTI = "https://openapi.naver.com/v1/search/image";

    public ImageResponseDto searchImage(String query, int display, int start, String sort, String filter){
        log.info("searchImage:::::::::::::::::::");
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Naver-Client-Id", clientId);
        headers.set("X-Naver-Client-Secret", clientSecret);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

        String url = NAVER_IMAGE_API_UTI+"?query="+query+"&display="+display+"&start="+start+"&sort="+sort+"&filter="+filter;

        HttpEntity<?> entity = new HttpEntity<>(headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    url,
                    HttpMethod.GET,
                    entity,
                    String.class);

            ObjectMapper objectMapper = new ObjectMapper();
            ImageResponseDto imageResponseDto = objectMapper.readValue(response.getBody(), ImageResponseDto.class);

//             프록시 서버 이용
//            for (ImageResponseDto.ImageItemDto item : imageResponseDto.getItems()) {
//                item.setThumbnail(proxyImage(item.getThumbnail()));
//                item.setLink(proxyImage(item.getLink()));
//            }

            return imageResponseDto;

        } catch (Exception e) {
            throw new RuntimeException("이미지 패치 실패", e);
        }
    }

    public String proxyImage(String imageUrl) {
        RestTemplate restTemplate = new RestTemplate();
        try {
            ResponseEntity<byte[]> response = restTemplate.getForEntity(imageUrl, byte[].class);
            String contentType = response.getHeaders().getContentType().toString();
            String base64Image = Base64.getEncoder().encodeToString(response.getBody());
            return "data:" + contentType + ";base64," + base64Image;
        } catch (Exception e) {
            log.error("이미지 프록시 실패: " + imageUrl, e);
            return null;
        }
    }
}