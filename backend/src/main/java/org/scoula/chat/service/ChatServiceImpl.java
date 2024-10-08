package org.scoula.chat.service;

import org.scoula.chat.dto.ChatRequestOptions;
import reactor.core.publisher.Mono;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public abstract class ChatServiceImpl implements ChatService{

    protected final WebClientService webClientService;

    public ChatServiceImpl(WebClientService webClientService) {
        this.webClientService = webClientService;
    }

    @Override
    public Mono<String> getResponse(String prompt, List<String> selectedAnswers) {
        Map<String,Object> optionsMap = createOptionsMap(getRequestOptions());
        return webClientService.sendRequestToAPI(prompt, getModelName(), getAdditionalContext(selectedAnswers),optionsMap);
    }

    protected abstract String getModelName();
    protected abstract String getAdditionalContext(List<String> selectedAnswers);
    protected abstract ChatRequestOptions getRequestOptions();

    protected Map<String,Object> createOptionsMap(ChatRequestOptions options){
        Map<String, Object> optionsMap = new HashMap<>();
        optionsMap.put("temperature",options.getTemperature());
        optionsMap.put("max_tokens", options.getMaxTokens());
        optionsMap.put("frequency_penalty", options.getFrequencyPenalty());
        optionsMap.put("presence_penalty", options.getPresencePenalty());
        optionsMap.put("n", options.getN());
        return optionsMap;
    }
}
