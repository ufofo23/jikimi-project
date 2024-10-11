package org.scoula.report.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ReportDTO {

    private int reportNo;
    private int analysisNo;
    private int propertyNo;
    private String address; // 주소
    private int totalScore; // 총점
    private Integer jeonseRate; // 전세가율
    private Boolean accordOwner; // 소유자, 계약자 일치 여부
    private Long maximumOfBond; // 채권최고액
    private String useType; // 주용도
    private Boolean violationStructure; // 위반건축물 여부
    private Date contractStartDate; // 계약 시작일
    //    private String kindOfLandrights; // 대지권등기
    private String commonOwner; // 공동소유 / 단독소유
    private Integer changeOwnerCount; // 소유권 변동 횟수
    private Double ownerState; // 전유부분
    private String contractName; // 계약자 성명
    private String ownership; // 소유자 성명
    private int price;

    // VO -> DTO
    public static ReportDTO of(ReportVO vo) {
        return vo == null ? null : ReportDTO.builder()
                .reportNo(vo.getReportNo())
                .analysisNo(vo.getAnalysisNo())
                .propertyNo(vo.getPropertyNo())
                .address(vo.getAddress())
                .totalScore(vo.getTotalScore())
                .jeonseRate(vo.getJeonseRate())
                .accordOwner(vo.getAccordOwner())
                .maximumOfBond(vo.getMaximumOfBond())
                .useType(vo.getUseType())
                .violationStructure(vo.getViolationStructure())
                .contractStartDate(vo.getContractStartDate())
//                .kindOfLandrights(vo.getKindOfLandrights())
                .commonOwner(vo.getCommonOwner())
                .changeOwnerCount(vo.getChangeOwnerCount())
                .ownerState(vo.getOwnerState())
                .contractName(vo.getContractName())
                .ownership(vo.getOwnership())
                .price(vo.getPrice())
                .build();
    }

    // DTO -> VO
    public ReportVO toVO() {
        return ReportVO.builder()
                .propertyNo(propertyNo)
                .analysisNo(analysisNo)
                .propertyNo(propertyNo)
                .address(address)
                .totalScore(totalScore)
                .jeonseRate(jeonseRate)
                .accordOwner(accordOwner)
                .maximumOfBond(maximumOfBond)
                .useType(useType)
                .violationStructure(violationStructure)
                .contractStartDate(contractStartDate)
//                .kindOfLandrights(kindOfLandrights)
                .commonOwner(commonOwner)
                .changeOwnerCount(changeOwnerCount)
                .ownerState(ownerState)
                .contractName(contractName)
                .ownership(ownership)
                .price(price)
                .build();
    }
}