package org.scoula.chat.dto;

import lombok.Getter;

@Getter
public class ChatRequestOptions {
    private final double temperature;
    private final int maxTokens;
    private final double frequencyPenalty;
    private final double presencePenalty;
    private final int n;

    public ChatRequestOptions(double temperature, int maxTokens, double frequencyPenalty, double presencePenalty, int n) {
        this.temperature = temperature;
        this.maxTokens = maxTokens;
        this.frequencyPenalty = frequencyPenalty;
        this.presencePenalty = presencePenalty;
        this.n = n;
    }
}