package org.scoula.chat.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatResponse {

    private String content;
    public ChatResponse(String content) {
        this.content = content;
    }

}