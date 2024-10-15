package org.scoula.chat.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class ChatRequest {

    private String prompt;
    private List<String> selectedAnswers;
}