package org.scoula.oauth.domain.client;

import org.scoula.oauth.domain.vo.OauthMember;
import org.scoula.oauth.domain.vo.OauthServerType;

public interface OauthMemberClient {

    OauthServerType supportServer();

    OauthMember fetch(String code);
}
