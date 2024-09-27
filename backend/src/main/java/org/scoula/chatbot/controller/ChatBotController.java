package org.scoula.chatbot.controller;

import org.scoula.chatbot.dto.ChatRequest;
import org.scoula.chatbot.dto.ChatResponse;
import org.scoula.chatbot.service.ChatBotService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping("/api/chat")
public class ChatBotController {

    private final ChatBotService chatBotService;

    public ChatBotController(ChatBotService chatBotService) {
        this.chatBotService = chatBotService;
    }

    @PostMapping(produces = "application/json;charset=UTF-8", consumes = "application/json;charset=UTF-8")
    public Mono<ChatResponse> chat(@RequestBody ChatRequest request) {
        return chatBotService.getChatBotResponse(request.getPrompt())
                .map(ChatResponse::new);
    }
}