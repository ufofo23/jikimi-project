package org.scoula.oauth.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.scoula.oauth.domain.VO.Role;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OauthMemberDTO {

    private Long id;

    private String oauthServerId;

    private String oauthServerType;

    private String nickname;

    private String profileImageUrl;

    private String userId;

    private Role role;
}
