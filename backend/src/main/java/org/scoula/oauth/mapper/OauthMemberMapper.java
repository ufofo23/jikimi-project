package org.scoula.oauth.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.scoula.oauth.domain.vo.OauthMember;

@Mapper
/*
 * OauthMember 데이터베이스 접근을 위한 매퍼 인터페이스
 */
public interface OauthMemberMapper {

    // userId(ex. Naver_n142314) 로 멤버 찾는 메서드
    OauthMember findByOauthId(@Param("userId") String userId);

    // OauthMember 저장 메서드
    int save(OauthMember oauthMember);
}
