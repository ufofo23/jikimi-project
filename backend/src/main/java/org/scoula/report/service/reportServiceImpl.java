package org.scoula.report.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.scoula.report.domain.ReportDTO;
import org.scoula.report.domain.ReportVO;
import org.scoula.report.mapper.ReportMapper;
import org.springframework.stereotype.Service;

import java.util.NoSuchElementException;
import java.util.Optional;

@Log4j
@Service
@RequiredArgsConstructor
public class reportServiceImpl implements reportService {

    final private ReportMapper mapper;
    final private CorMapper corMapper;
    final private BmlMapper bmlMapper;

    @Override
    public ReportDTO get(int analysisNo) {
        ReportDTO report = ReportDTO.of(mapper.get(analysisNo));
        return Optional.ofNullable(report)
                .orElseThrow(NoSuchElementException::new);
    }

    @Override
    public int create(ReportDTO report) {
        ReportVO reportVO = report.toVO();
        return mapper.create(reportVO);
    }

    @Override
    public ReportDTO analysis(int analysisNo, int propertyNo, String address, int jeonsePrice, int price, String ContractName) {
        ReportDTO report = new ReportDTO();

        CopyOfRegisterDto cor = corMapper.selectCopyOfResister(analysisNo);
        BuildingManagementLedgerDto bml = bmlMapper.selectBuildingData(analysisNo);

        report.setPropertyNo(propertyNo);
        report.setAddress(address);
        report.setJeonseRate(jeonsePrice/price);

        if(ContractName != null) {
            report.setAccordOwner(
                    isAccordOwner(ContractName, cor.getOwnerShip())
            );
        }

        report.setMaximumOfBond(cor.getMaximumOfBond());
        report.setUseType(bml.getUseType());
        report.setViolationStructure(bml.isViolationStructure());
        report.setKindOfLandrights(cor.getKindOfLandrights());
        report.setCommonOwner(cor.getCommonOwner());
        report.setChangeOwnerCount(cor.getChangeOwnerCount());
        report.setOwnerState(cor.getOwnerState());

        report.setTotalScore(
            getTotalScore(report, price)
        );

        return report;
    }

    private boolean isAccordOwner(String contractName, String corName) {
        return contractName.equals(corName);
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
        if(!report.isAccordOwner())
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
        if(!report.getUseType().equals("거주용"))
            return 0;

        // 위반 건축물이면 고위험
        if(report.isViolationStructure())
            return 0;

        // 대지권 등기에 따른 감점 (대지권 등기에 따라 어떻게 값이 들어가는 지 확인 필요)
        String landrights = report.getKindOfLandrights();
        if(landrights.equals("미등기"))
            totalScore -= 10;
        else if(landrights.equals("불명확"))
            totalScore -= 15;
        else if(landrights.equals("없음"))
            return 0;

        // 총점 50점 기준
        if(totalScore < 50)
            return 0;

        return totalScore;
    }
}
