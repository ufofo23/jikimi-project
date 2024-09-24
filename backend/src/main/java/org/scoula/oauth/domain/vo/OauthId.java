package org.scoula.oauth.domain.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OauthId {

    private String oauthServerId;

    private OauthServerType oauthServerType;
}
