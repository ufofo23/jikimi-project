package org.scoula.oauth.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.scoula.oauth.domain.vo.OauthId;
import org.scoula.oauth.domain.vo.OauthMemberVO;
import org.scoula.oauth.domain.vo.Role;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OauthMemberDTO {

    private Long id;

    private OauthId oauthId;

    private String nickname;

    private String profileImageUrl;

    private String userId;

    private String email;

    private String name;

    private Integer gender;

    private Integer age;

    private String birthday;

    private String mobileE164;

    private Role role;

    // VO -> DTO
    public static OauthMemberDTO of(OauthMemberVO vo) {
        return vo == null ? null : OauthMemberDTO.builder()
                .id(vo.getId())
                .oauthId(vo.getOauthId())
                .nickname(vo.getNickname())
                .profileImageUrl(vo.getProfileImageUrl())
                .userId(vo.getUserId())
                .email(vo.getEmail())
                .name(vo.getName())
                .gender(vo.getGender())
                .age(vo.getAge())
                .birthday(vo.getBirthday())
                .mobileE164(vo.getMobileE164())
                .role(vo.getRole())
                .build();
    }
}
