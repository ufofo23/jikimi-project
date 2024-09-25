package org.scoula.oauth.infra.oauth.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.scoula.oauth.infra.oauth.google.client.GoogleApiClient;
import org.scoula.oauth.infra.oauth.google.client.GoogleApiClientImpl;
import org.scoula.oauth.infra.oauth.naver.client.NaverApiClient;
import org.scoula.oauth.infra.oauth.naver.client.NaverApiClientImpl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

/*
 * OAuth 관련 HTTP 클라이언트 및 Jackson ObjectMapper 설정
 */
@Configuration
public class HttpInterfaceConfig {

    @Bean
    public RestTemplate restTemplate() {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());

        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter(objectMapper);

        RestTemplate restTemplate = new RestTemplate();
        restTemplate.getMessageConverters().add(0, converter);

        return restTemplate;
    }

    @Bean
    public ObjectMapper objectMapper() {
        return new ObjectMapper();
    }

    @Bean
    public NaverApiClient naverApiClient(RestTemplate restTemplate) {
        return new NaverApiClientImpl(restTemplate);
    }

    @Bean
    public GoogleApiClient googleApiClient(RestTemplate restTemplate) {
        return new GoogleApiClientImpl(restTemplate);
    }
}
