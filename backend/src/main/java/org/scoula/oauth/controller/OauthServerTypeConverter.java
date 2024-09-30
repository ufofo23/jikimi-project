package org.scoula.oauth.controller;

import org.scoula.oauth.domain.VO.OauthServerType;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/*
 * String을 OauthServerType으로 변환
 */
@Component
public class OauthServerTypeConverter implements Converter<String, OauthServerType> {

    @Override
    public OauthServerType convert(String source) {
        try {
            return OauthServerType.fromName(source);
        } catch (RuntimeException e) {
            throw new IllegalArgumentException("Invalid OAuth server type: " + source, e);
        }
    }
}
