package org.scoula.oauth.domain.vo;

import static java.util.Locale.ENGLISH;

/*
 * 제공하는 서버의 종류를 명시
 * 예) kakao -> OauthServerType.KAKAO
 */
public enum OauthServerType {

    KAKAO,

    NAVER,

    GOOGLE;

    public static OauthServerType fromName(String type) {
        try {
            return OauthServerType.valueOf(type.toUpperCase(ENGLISH));
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("지원하지 않는 OAuth 서버 타입입니다: " + type);
        }
    }
}
