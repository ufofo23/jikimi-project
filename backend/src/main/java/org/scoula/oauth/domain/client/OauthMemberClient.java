package org.scoula.oauth.domain.client;

import org.scoula.oauth.domain.VO.OauthMemberVO;
import org.scoula.oauth.domain.VO.OauthServerType;

public interface OauthMemberClient {

    OauthServerType supportServer();

    OauthMemberVO fetch(String code);
}
