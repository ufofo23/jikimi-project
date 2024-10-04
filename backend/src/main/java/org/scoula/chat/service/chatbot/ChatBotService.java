package org.scoula.chat.service.chatbot;

import org.scoula.chat.dto.ChatRequestOptions;
import org.scoula.chat.service.ChatServiceImpl;
import org.scoula.chat.service.WebClientService;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.util.List;

@Service
public class ChatBotService extends ChatServiceImpl {
    public ChatBotService(WebClientService webClientService) {
        super(webClientService);
    }

    @Override
    protected String getModelName() {
        return "gpt-3.5-turbo";
    }

    @Override
    protected String getAdditionalContext(List<String> selectedAnswers) {
        return "당신의 이름은 '부기봇'이고, 한국의 부동산 전문가입니다. 한국에 사는 사람에게 2줄 이내로 요약된 정보를 존댓말로 제공해주세요.투자와 관련된 정보는 제한해주세요.";
    }

    @Override
    protected ChatRequestOptions getRequestOptions() {
        return new ChatRequestOptions(0.7, 150, 0.0, 0.0, 1);
    }


}
