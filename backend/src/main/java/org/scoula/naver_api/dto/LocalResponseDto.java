package org.scoula.naver_api.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class LocalResponseDto {
    private String title;
    private String link;
    private String description;
    private String lastBuildDate;
    private int total;
    private int start;
    private int display;
    private List<LocalItemDto> items;

    @Getter
    @Setter
    public static class LocalItemDto{
        private String title;
        private String link;
        private String category;
        private String description;
        private String telephone;
        private String address;
        private String roadAddress;
        private String mapx;
        private String mapy;
    }
}
