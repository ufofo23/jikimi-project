package org.scoula.oauth.domain.authcode;

import org.scoula.oauth.domain.VO.OauthServerType;

/* 인증 코드 요청 URL 제공 인터페이스 */
public interface AuthCodeRequestUrlProvider {

    OauthServerType supportServer();

    String provide();
}
