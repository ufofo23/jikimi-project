package org.scoula.security.util;

import lombok.extern.log4j.Log4j;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.scoula.config.RootConfig;
import org.scoula.security.config.SecurityConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import static org.junit.jupiter.api.Assertions.*;


@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = { RootConfig.class, SecurityConfig.class })
@Log4j
class JwtProcessorTest {

    @Autowired
    JwtProcessor jwtProcessor;

    @Test
    void generateToken() {
        String username = "user0";
        String token = jwtProcessor.generateToken(username);
        log.info(token);
        assertNotNull(token);
    }

    @Test
    void getusername() {
        String token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ1c2VyMCIsImlhdCI6MTcyNDIxOTI5NiwiZXhwIjoxNzI0MjE5NTk2fQ.tar1kpWfEgwcUvPGM4kYe09tjKX-SQyDQC_Y1GMIDrYPVgVZf-Do4NKrYJOxpbccHwoc_J7Aj0tCf3RKKpgMJQ";

        String username = jwtProcessor.getUsername(token);
        log.info(username);
        assertNotNull(username);
    }

    @Test
    void validateToken() {
        // 5분 경과 후 테스트
        String token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ1c2VyMCIsImlhdCI6MTcyNDIxOTI5NiwiZXhwIjoxNzI0MjE5NTk2fQ.tar1kpWfEgwcUvPGM4kYe09tjKX-SQyDQC_Y1GMIDrYPVgVZf-Do4NKrYJOxpbccHwoc_J7Aj0tCf3RKKpgMJQ";

        boolean isValid = jwtProcessor.validateToken(token); // 5분 이후면 예외 발생
        log.info(isValid);
        assertTrue(isValid);    // 5분 전이면 true
    }
}