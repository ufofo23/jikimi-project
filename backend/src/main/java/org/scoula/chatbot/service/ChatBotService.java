package org.scoula.chatbot.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.netty.channel.nio.NioEventLoopGroup;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;
import reactor.netty.http.client.HttpClient;

import javax.annotation.PreDestroy;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

@Service
public class ChatBotService {

    @Value("${openai.api.key}")
    private String apiKey;
    private final WebClient webClient;
    private final ObjectMapper objectMapper;
    private final NioEventLoopGroup eventLoopGroup;
    private static final String API_URL = "https://api.openai.com/v1/chat/completions";
    private static final String MODEL_NAME = "gpt-3.5-turbo";
    private static final String SYSTEM_ROLE = "user";
    private static final String ADDITIONAL_CONTEXT = "당신의 이름은 '지키미'이고, 한국의 부동산 전문가입니다. 한국에 사는 사람에게 2줄 이내로 요약된 정보를 존댓말로 제공해주세요.투자와 관련된 정보는 제한해주세요.";

    public ChatBotService(WebClient.Builder webClientBuilder, ObjectMapper objectMapper) {
        eventLoopGroup = new NioEventLoopGroup(4);
        HttpClient httpClient = HttpClient.create().runOn(eventLoopGroup);
        this.webClient = webClientBuilder
                .clientConnector(new ReactorClientHttpConnector(httpClient))
                .baseUrl(API_URL)
                .build();
        this.objectMapper = objectMapper;
    }

    public Mono<String> getChatBotResponse(String prompt) {
        if (prompt == null || prompt.trim().isEmpty()) {
            return Mono.error(new IllegalArgumentException("Prompt cannot be null or empty"));
        }

        String fullPrompt = ADDITIONAL_CONTEXT + " " + prompt;
        String requestBody = createRequestBody(fullPrompt);

        return webClient.post()
                .contentType(MediaType.APPLICATION_JSON)
                .header("Authorization", "Bearer " + apiKey)
                .bodyValue(requestBody)
                .retrieve()
                .bodyToMono(String.class)
                .map(this::extractContentFromResponse)
                .onErrorResume(e -> Mono.error(new RuntimeException("Error calling OpenAI API: " + e.getMessage(), e)));
    }

    private String createRequestBody(String fullPrompt) {
        Map<String, Object> message = new HashMap<>();
        message.put("role", SYSTEM_ROLE);
        message.put("content", fullPrompt);

        Map<String, Object> requestBodyMap = new HashMap<>();
        requestBodyMap.put("model", MODEL_NAME);
        requestBodyMap.put("messages", Collections.singletonList(message));

        try {
            return objectMapper.writeValueAsString(requestBodyMap);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("Error creating JSON request", e);
        }
    }

    private String extractContentFromResponse(String responseBody) {
        try {
            JsonNode rootNode = objectMapper.readTree(responseBody);
            return rootNode.path("choices").get(0).path("message").path("content").asText();
        } catch (JsonProcessingException e) {
            throw new RuntimeException("Error parsing API response", e);
        }
    }

    @PreDestroy
    public void cleanup() {
        eventLoopGroup.shutdownGracefully();
    }
}