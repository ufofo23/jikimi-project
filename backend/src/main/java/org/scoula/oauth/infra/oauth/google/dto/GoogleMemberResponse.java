package org.scoula.oauth.infra.oauth.google.dto;

import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.annotation.JsonNaming;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.scoula.oauth.domain.vo.OauthId;
import org.scoula.oauth.domain.vo.OauthMember;
import org.scoula.oauth.domain.vo.OauthServerType;

@JsonNaming(PropertyNamingStrategies.SnakeCaseStrategy.class)
@Data
@NoArgsConstructor
@AllArgsConstructor
public class GoogleMemberResponse {
    private String id;
    private String email;
    private String givenName; // 이름
    private String familyName; // 성
    private String picture; // 프로필 사진 URL
    private String gender; // 성별
    private String birthday; // 생일 (형식: YYYY-MM-DD)
    private Boolean verifiedEmail;
    private String name;
    private String locale;

    public OauthMember toDomain() {
        Integer genderValue = null;
        if ("male".equalsIgnoreCase(gender)) {
            genderValue = 1;
        } else if ("female".equalsIgnoreCase(gender)) {
            genderValue = 0;
        }

        return OauthMember.builder()
                .oauthId(new OauthId(id, OauthServerType.GOOGLE)) // OauthServerType.GOOGLE을 사용
                .email(email)
                .name(familyName+givenName)
                .gender(genderValue)
                .birthday(birthday)
                .profileImageUrl(picture)
                .build();
    }
}