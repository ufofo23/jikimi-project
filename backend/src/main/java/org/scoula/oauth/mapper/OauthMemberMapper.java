package org.scoula.oauth.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.scoula.oauth.domain.DTO.OauthMemberDTO;
import org.scoula.oauth.domain.VO.OauthMemberVO;

@Mapper
/*
 * OauthMember 데이터베이스 접근을 위한 매퍼 인터페이스
 */
public interface OauthMemberMapper {

    // userId(ex. Naver_n142314) 로 멤버 찾는 메서드
    OauthMemberVO findByOauthId(@Param("userId") String userId);

    // OauthMember 저장 메서드
    int save(OauthMemberVO oauthMemberVO);

    // OauthMember 업데이트
    int updateOauthInfo(@Param("userId") String userId, @Param("member") OauthMemberDTO member);
}
