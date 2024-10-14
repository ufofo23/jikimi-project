package org.scoula.naver_api.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class BlogResponseDto {
    private String lastBuildDate;
    private int total;
    private int start;
    private int display;
    private List<BlogItemDTO> items;

    @Getter
    @Setter
    public static class BlogItemDTO {
        private String title;
        private String link;
        private String description;
        private String bloggername;
        private String bloggerlink;
        private String postdate;
    }
}
