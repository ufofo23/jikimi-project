package org.scoula.test.mapper;

import org.scoula.test.common.BmlInfo;
import org.scoula.test.common.CorInfo;

public interface TestMapper {

    public int createCor(CorInfo corInfo);

    public int createBml(BmlInfo bmlInfo);

}
