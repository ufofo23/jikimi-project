package org.scoula.chat.service.scenario;

import org.scoula.chat.dto.ChatRequestOptions;
import org.scoula.chat.service.ChatServiceImpl;
import org.scoula.chat.service.WebClientService;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

import java.util.List;

@Service
public class ScenarioService extends ChatServiceImpl {

    public ScenarioService(WebClientService webClientService) {
        super(webClientService);
    }

    @Override
    protected String getModelName() {
        return "gpt-4o";
    }

    @Override
    protected String getAdditionalContext(List<String> selectedAnswers) {
        String userSituation = String.join(", ", selectedAnswers);
        return "You are an expert in real estate fraud in Korea. I have little experience in real estate transactions and am currently in the process of signing a contract or have just completed one. Based on my situation, please present three types of real estate fraud that could occur in a scenario format. Each scenario should include: 1.Please provide the answer in korean 2. Each scenario should begin with /start/ 3. Each scenario must include a name of scenario, a description of the situation in which the fraud occurs, the type of fraud, and measures to address it, be written in markdown format and end with /end/. 4. A description of the situation in which the fraud occurs, with a minimum of 15 lines 5. Each scenario should be written in at least 50 lines. 6. The fraud scenarios should be written in a friendly and easily understandable tone. For reference, my situations include ["+ userSituation + "]";
    }

    @Override
    protected ChatRequestOptions getRequestOptions() {
        return new ChatRequestOptions(0.7, 2000, 0.0, 0.0, 1);
    }
}
