package org.scoula.oauth.domain.VO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.scoula.oauth.domain.DTO.OauthMemberDTO;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class OauthMemberVO {

    private Long id;

    private OauthId oauthId;

    private String nickname;

    private String profileImageUrl;

    private String userId;

    private String email;

    private String name;

    private Integer gender;

    private String birthday;

    private String mobileE164;

    private Role role;

}
