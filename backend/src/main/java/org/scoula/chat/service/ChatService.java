package org.scoula.chat.service;

import reactor.core.publisher.Mono;

import java.util.List;

public interface ChatService {
    Mono<String> getResponse(String prompt, List<String> selectedAnswers);
}