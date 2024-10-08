package org.scoula.report.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ReportDTO {

    private int reportNo;
    private int propertyNo;
    private String address; // 주소
    private int totalScore; // 총점
    private int jeonseRate; // 전세가율
    private boolean accordOwner; // 소유자, 계약자 일치 여부
    private int maximumOfBond; // 채권최고액
    private String useType; // 주용도
    private boolean violationStructure; // 위반건축물 여부
//    private String kindOfLandrights; // 대지권등기
    private String commonOwner; // 공동소유 / 단독소유
    private String changeOwnerCount; // 소유권 변동 횟수
    private Double ownerState; // 전유부분

    // VO -> DTO
    public static ReportDTO of(ReportVO vo) {
        return vo == null ? null : ReportDTO.builder()
                .reportNo(vo.getReportNo())
                .propertyNo(vo.getPropertyNo())
                .address(vo.getAddress())
                .totalScore(vo.getTotalScore())
                .jeonseRate(vo.getJeonseRate())
                .accordOwner(vo.isAccordOwner())
                .maximumOfBond(vo.getMaximumOfBond())
                .useType(vo.getUseType())
                .violationStructure(vo.isViolationStructure())
//                .kindOfLandrights(vo.getKindOfLandrights())
                .commonOwner(vo.getCommonOwner())
                .changeOwnerCount(vo.getChangeOwnerCount())
                .ownerState(vo.getOwnerState())
                .build();
    }

    // DTO -> VO
    public ReportVO toVO() {
        return ReportVO.builder()
                .propertyNo(propertyNo)
                .address(address)
                .totalScore(totalScore)
                .jeonseRate(jeonseRate)
                .accordOwner(accordOwner)
                .maximumOfBond(maximumOfBond)
                .useType(useType)
                .violationStructure(violationStructure)
//                .kindOfLandrights(kindOfLandrights)
                .commonOwner(commonOwner)
                .changeOwnerCount(changeOwnerCount)
                .ownerState(ownerState)
                .build();
    }
}
