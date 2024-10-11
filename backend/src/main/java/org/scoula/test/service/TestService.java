package org.scoula.test.service;

import org.scoula.test.common.BmlInfo;
import org.scoula.test.common.CorInfo;
import org.scoula.test.common.Payload;

public interface TestService {

    public int createCor(CorInfo corInfo);

    public int createBml(BmlInfo bmlInfo);

}
