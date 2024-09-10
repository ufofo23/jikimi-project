package org.scoula.security;

import lombok.extern.log4j.Log4j;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.scoula.config.RootConfig;
import org.scoula.security.account.domain.AuthVO;
import org.scoula.security.account.domain.MemberVO;
import org.scoula.security.account.mapper.UserDetailsMapper;
import org.scoula.security.config.SecurityConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = {
        RootConfig.class,
        SecurityConfig.class
})
@Log4j
public class PasswordEncoderTest {

    @Autowired
    private PasswordEncoder pwEncoder;

    @Autowired
    private UserDetailsMapper mapper;

    @Test
    public void testEncode() {
        String str = "1234";

        String enStr = pwEncoder.encode(str);
        log.info("password: " + enStr);

        String enStr2 = pwEncoder.encode(str);
        log.info("password: " + enStr2);

        log.info("match : " + pwEncoder.matches(str, enStr));
        log.info("match : " + pwEncoder.matches(str, enStr2));
    }

    @Test
    public void testGet() {
        MemberVO member = mapper.get("admin");
        log.info("member");

        for(AuthVO auth : member.getAuthList()) {
            log.info(auth);
        }
    }
}
