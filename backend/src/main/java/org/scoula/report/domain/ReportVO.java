package org.scoula.report.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ReportVO {

    private int reportNo;
    private int propertyNo;
    private String address; // 주소
    private int totalScore; // 총점
    private int jeonseRate; // 전세가율
    private boolean accordOwner; // 소유자, 계약자 일치 여부
    private int maximumOfBond; // 채권최고액
    private String useType; // 주용도
    private boolean violationStructure; // 위반건축물 여부
    private String kindOfLandrights; // 대지권등기
    private String commonOwner; // 공동소유 / 단독소유
    private int changeOwnerCount; // 소유권 변동 횟수
    private String ownerState; // 전유부분
}