package org.scoula.report.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.scoula.report.domain.ReportDTO;
import org.scoula.report.domain.ReportVO;
import org.scoula.report.mapper.ReportMapper;
import org.scoula.safety_inspection.infra.bml.dto.BuildingManagementLedgerDto;
import org.scoula.safety_inspection.infra.bml.mapper.BuildingManagementLedgerMapper;
import org.scoula.safety_inspection.infra.cors.dto.CopyOfRegisterDto;
import org.scoula.safety_inspection.infra.cors.mapper.CopyOfRegisterMapper;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Log4j
@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService {

    final private ReportMapper mapper;
    final private CopyOfRegisterMapper corMapper;
    final private BuildingManagementLedgerMapper bmlMapper;

    @Override
    public ReportDTO get(int analysisNo) {
        ReportDTO report = ReportDTO.of(mapper.get(analysisNo));
        return Optional.ofNullable(report)
                .orElseThrow(NoSuchElementException::new);
    }

    @Override
    public int create(ReportDTO report, Integer analysisNo) {
        ReportVO reportVO = report.toVO();
        reportVO.setAnalysisNo(analysisNo);
        return mapper.create(reportVO);
    }

    @Override
    public int delete(int analysisNo) {
        return mapper.delete(analysisNo);
    }

    @Override
    public ReportDTO analysis(int analysisNo, String propertyNo, Map<String, Object> payload) {
        ReportDTO report = new ReportDTO();

        CopyOfRegisterDto cor = corMapper.selectCopyOfRegister(analysisNo);
        log.info("corDTO :::::::::::::: " + cor.toString());
        BuildingManagementLedgerDto bml = bmlMapper.selectBuildingData(analysisNo);
        log.info("bmlDTO :::::::::::::: " + bml.toString());


        report.setPropertyNo(Integer.parseInt(propertyNo));
        report.setAddress(payload.get("addr-jibun-address").toString());

        // jeonsePrice: 0, null 예외처리 - jeonseRate을 null 값으로 두고 프론트에서 "판단 불가"로 표기
        if (payload.get("jeonsePrice") != null) {
            int jeonsePrice = Integer.parseInt(payload.get("jeonsePrice").toString());
            if (jeonsePrice != 0) {
                report.setJeonseRate(jeonsePrice / Integer.parseInt(payload.get("price").toString()));
            }
        } else {
            report.setJeonseRate(null);
        }

        // contractName : null, "" 예외처리 - accordOwner을 null 값으로 두고 프론트에서 "판단 불가"로 표기
        // payload.get("contractName")이 List가 아니면 제외
        if(payload.get("contractName") != null && payload.get("contractName") instanceof List) {
            // 공동 소유를 감안하여 리스트에 받음
            List<String> contractNameList = (List<String>) payload.get("contractName");

            String ownership = cor.getOwnership();

            // 정규 표현식을 사용하여 이름 부분만 추출
            Pattern pattern = Pattern.compile("(\\S+)(?= \\([^)]*\\))");
            Matcher matcher = pattern.matcher(ownership);

            // 결과를 저장할 List
            List<String> ownershipList = new ArrayList<>();

            // 매칭되는 이름을 찾기
            while (matcher.find()) {
                if(matcher.group(1).isEmpty()) report.setAccordOwner(null);
                ownershipList.add(matcher.group(1)); // 첫 번째 그룹이 이름
            }

            report.setAccordOwner(
                    isAccordOwner(contractNameList, ownershipList)
            );
        } else {
            report.setAccordOwner(null);
        }

        // 채권최고액이 null이면 판단불가
        if(cor.getMaximumOfBond() == null) {
            report.setMaximumOfBond(null);
        } else {
            report.setMaximumOfBond(cor.getMaximumOfBond());
        }

        // 주용도가 null이면 판단불가
        if(bml.getResContents() == null) {
            report.setUseType(null);
        } else {
            report.setUseType(bml.getResContents());
        }

        // 위반건축물이 null이면 판단불가
        if(bml.getResViolationStatus() == null) {
            report.setViolationStructure(null);
        } else {
            report.setViolationStructure(bml.getResViolationStatus());
        }

        // 채권최고액이 null이면 판단불가
        if(cor.getMaximumOfBond() == null) {
            report.setMaximumOfBond(null);
        } else {
            report.setMaximumOfBond(cor.getMaximumOfBond());
        }

        // 주용도가 null이면 판단불가
        if(bml.getResContents() == null) {
            report.setUseType(null);
        } else {
            report.setUseType(bml.getResContents());
        }

        // 위반건축물이 null이면 판단불가
        if(bml.getResViolationStatus() == null) {
            report.setViolationStructure(null);
        } else {
            report.setViolationStructure(bml.getResViolationStatus());
        }

//        report.setKindOfLandrights(cor.getKindOfLandrights());

        // 공동소유/단독소유가 null이면 판단불가
        if(cor.getCommonOwner() == null) {
            report.setCommonOwner(null);
        } else {
            report.setCommonOwner(cor.getCommonOwner());
        }

        // 소유자 변동 횟수가 null이면 판단 불가
        if(cor.getChangeOwnerCount() == null) {
            report.setChangeOwnerCount(null);
        } else {
            report.setChangeOwnerCount(cor.getChangeOwnerCount());
        }

        // 전유부분이 null이면 판단불가
        if(cor.getOwnerState() == null) {
            report.setOwnerState(null);
        } else {
            report.setOwnerState(cor.getOwnerState());
        }

        // 공동소유/단독소유가 null이면 판단불가
        if(cor.getCommonOwner() == null) {
            report.setCommonOwner(null);
        } else {
            report.setCommonOwner(cor.getCommonOwner());
        }

        // 소유자 변동 횟수가 null이면 판단 불가
        if(cor.getChangeOwnerCount() == null) {
            report.setChangeOwnerCount(null);
        } else {
            report.setChangeOwnerCount(cor.getChangeOwnerCount());
        }

        // 전유부분이 null이면 판단불가
        if(cor.getOwnerState() == null) {
            report.setOwnerState(null);
        } else {
            report.setOwnerState(cor.getOwnerState());
        }

        report.setTotalScore(
                getTotalScore(report, Integer.parseInt(payload.get("price").toString()))
        );

        log.info("TotalllllllllllllllllScoreeeeeeeeeeeeeeeee");
        log.info(report.getTotalScore());

        return report;
    }

    public static boolean isAccordOwner(List<String> contractNameList, List<String> ownershipList) {
        // 1. 두 리스트의 크기가 같지 않으면 일대일 매칭 불가
        if (contractNameList.size() != ownershipList.size()) {
            return false;
        }

        // 2. 각 인덱스의 원소가 같은지 확인
        for (int i = 0; i < contractNameList.size(); i++) {
            if (!contractNameList.get(i).equals(ownershipList.get(i))) {
                return false;
            }
        }

        // 모든 원소가 동일하면 true 반환
        return true;
    }

    private int getTotalScore(ReportDTO report, int price) {

        int totalScore = 100;

        // 전세가율에 따른 감점
        int jeonseRate = report.getJeonseRate();
        if(jeonseRate > 70) {
            if(jeonseRate <= 80)
                totalScore -= 7;
            else if(jeonseRate <= 90)
                totalScore -= 17;
            else
                return 0;
        }

        // 계약자, 소유자 불일치 시 고위험
        if(report.getAccordOwner()!=null && !report.getAccordOwner())
            return 0;

        // 근저당권(채권 최고액)에 따른 감점
        int maximumOfBond = report.getMaximumOfBond();
        if(maximumOfBond != 0) {
            int rate = maximumOfBond / price;
            if(rate <= 30)
                totalScore -= 5;
            else if(rate < 50)
                totalScore -= 10;
            else if(rate < 70)
                totalScore -= 15;
            else
                return 0;
        }

        // 주용도가 거주가 아니면 고위험 (거주일때 어떻게 값이 들어가는 지 확인 필요)
        String useType = report.getUseType();
        if(!(useType.contains("아파트") || useType.contains("주택") || useType.contains("주거")))
            return 0;

        // 위반 건축물이면 고위험
        if(report.getViolationStructure() == null || report.getViolationStructure())
            return 0;

//        // 대지권 등기에 따른 감점 (대지권 등기에 따라 어떻게 값이 들어가는 지 확인 필요)
//        String landrights = report.getKindOfLandrights();
//        if(landrights.equals("미등기"))
//            totalScore -= 10;
//        else if(landrights.equals("불명확"))
//            totalScore -= 15;
//        else if(landrights.equals("없음"))
//            return 0;

        // 총점 50점 기준
        if(totalScore < 50)
            return 0;

        return totalScore;
    }
}