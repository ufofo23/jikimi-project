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
        return "You are an expert in real estate fraud in Korea. I have little experience in real estate transactions and am currently in the process of signing a contract or have just completed one. Based on my situation, please present three types of real estate fraud that could occur in a scenario format. Each scenario should include: 1.Please provide the answer in korean 2. Each scenario should include the name of the scenario, the situation in which the fraud occurred, a description of the type of fraud, and a solution to address it. 3. The name of the scenario should start with $start-name$ and end with $end-name$ 4. The situation in which the fraud occurred should start with $start-fraud$ and end with $end-fraud$ 5. The description of the type of fraud should start with $start-type$ and end with $end-type$ 6. The explanation of the solution should start with $start-address$ and end with $end-address$ 7. A description of the situation in which the fraud occurs, with a minimum of 20 lines 8. Each scenario should be written in at least 70 lines 9. Please make sure to respond in the requested sentence format 10. The fraud scenarios should be written in a friendly and easily understandable tone. For reference, my situations include ["+ userSituation + "]";
    }

    @Override
    protected ChatRequestOptions getRequestOptions() {
        return new ChatRequestOptions(0.7, 4000, 0.0, 0.0, 1);
    }
}
