package org.scoula.naver_api.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.List;


@Getter
@Setter
public class ImageResponseDto {
    private String title;
    private String link;
    private String description;
    private String lastBuildDate;
    private int total;
    private int start;
    private int display;
    private List<ImageItemDto> items;

    @Getter
    @Setter
    public static class ImageItemDto{
        private String title;
        private String link;
        private String thumbnail;
        private int sizeheight;
        private int sizewidth;
    }
}
