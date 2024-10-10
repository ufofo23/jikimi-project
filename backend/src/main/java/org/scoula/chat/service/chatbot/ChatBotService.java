package org.scoula.chat.service.chatbot;

import org.scoula.chat.dto.ChatRequestOptions;
import org.scoula.chat.service.ChatServiceImpl;
import org.scoula.chat.service.WebClientService;
import org.scoula.dictionary.domain.DictionaryVO;
import org.scoula.dictionary.mapper.DictionaryMapper;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

@Service
public class ChatBotService extends ChatServiceImpl {

    private final DictionaryMapper dictionaryMapper;

    public ChatBotService(WebClientService webClientService, DictionaryMapper dictionaryMapper) {
        super(webClientService);
        this.dictionaryMapper = dictionaryMapper;
    }


    @Override
    public Mono<String> getResponse(String prompt, List<String> selectedAnswers) {
        System.out.println("prompt = " + prompt);
        return super.getResponse(prompt, selectedAnswers)
                .map(this::extractWordToLink);
    }

    private String extractWordToLink(String response) {
        System.out.println("response = " + response);
        List<DictionaryVO> dictionaries;
        try {
            dictionaries = dictionaryMapper.getList();
            dictionaries.sort((a, b) ->
                    b.getDictionaryTitle().length() - a.getDictionaryTitle().length());

            for (DictionaryVO dictionary : dictionaries) {
                String title = dictionary.getDictionaryTitle();
                String pattern = "(?<!\\w)" + Pattern.quote(title) + "(?!\\w)";
                String newResponse = response.replaceAll(pattern,
                        String.format("<a href='/study/dictionary/detail/%d' class='dictionary-link' style='color: green; font-weight: bold;'>%s</a>",
                                dictionary.getDictionaryNo(), title));

                // response가 변경되었으면 바로 break
                if (!newResponse.equals(response)) {
                    response = newResponse;
                    break; // 변경된 경우 루프 종료
                }
            }
            return response;
        } catch (Exception e) {
            return response;
        }


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
