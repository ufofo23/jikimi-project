package org.scoula.oauth.domain.client;

import org.scoula.oauth.domain.vo.OauthMemberVO;
import org.scoula.oauth.domain.vo.OauthServerType;

public interface OauthMemberClient {

    OauthServerType supportServer();

    OauthMemberVO fetch(String code);
}
