package org.scoula.test.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.scoula.report.mapper.ReportMapper;
import org.scoula.test.common.BmlInfo;
import org.scoula.test.common.CorInfo;
import org.scoula.test.common.Payload;
import org.scoula.test.mapper.TestMapper;
import org.springframework.stereotype.Service;

@Log4j
@Service
@RequiredArgsConstructor
public class TestSerivceImpl implements TestService {

    final private TestMapper testMapper;
    final private ReportMapper reportMapper;

    @Override
    public int createCor(CorInfo corInfo) {
        return testMapper.createCor(corInfo);
    }

    @Override
    public int createBml(BmlInfo bmlInfo) {
        return testMapper.createBml(bmlInfo);
    }
}
