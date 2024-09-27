package org.scoula.oauth.service;

import lombok.RequiredArgsConstructor;
import org.scoula.oauth.domain.authcode.AuthCodeRequestUrlProviderComposite;
import org.scoula.oauth.domain.client.OauthMemberClientComposite;
import org.scoula.oauth.domain.vo.OauthMember;
import org.scoula.oauth.domain.vo.OauthServerType;
import org.scoula.oauth.domain.vo.Role;
import org.scoula.oauth.jwt.JwtUtil;
import org.scoula.oauth.mapper.OauthMemberMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

@Service
@RequiredArgsConstructor
/*
 * OAuth 인증 및 회원 관리를 처리하는 서비스 클래스;
 */
public class OauthService {

    private final AuthCodeRequestUrlProviderComposite authCodeRequestUrlProviderComposite;

    private final OauthMemberClientComposite oauthMemberClientComposite;

    private final OauthMemberMapper oauthMemberMapper;

    private final JwtUtil jwtUtil;


    public String getAuthCodeRequestUrl(OauthServerType oauthServerType) {
        return authCodeRequestUrlProviderComposite.provide(oauthServerType);
    }


    @Transactional
    public void login(OauthServerType oauthServerType, String authCode, HttpServletResponse response) {
        OauthMember oauthMember = oauthMemberClientComposite.fetch(oauthServerType, authCode);

        String userId = oauthServerType.name() + "_" + oauthMember.getOauthId().getOauthServerId().replace(" ", "");
        oauthMember.setUserId(userId);
        oauthMember.setRole(Role.USER);

        OauthMember saved = oauthMemberMapper.findByOauthId(oauthMember.getUserId());

        if (saved == null) {
            oauthMemberMapper.save(oauthMember);
        }

        String jwtToken = jwtUtil.generateToken(oauthMember.getUserId(), oauthMember.getRole());

        Cookie jwtCookie = new Cookie("jwtToken", jwtToken);
        jwtCookie.setHttpOnly(false);
        jwtCookie.setSecure(false); // 개발 중에만 false -> https만 지원함
        jwtCookie.setPath("/");
        jwtCookie.setMaxAge(1 * 60 * 60);

        // 응답에 쿠키 추가
        response.addCookie(jwtCookie);
    }
}
