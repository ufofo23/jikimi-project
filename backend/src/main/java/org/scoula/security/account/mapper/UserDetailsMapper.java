package org.scoula.security.account.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.scoula.security.account.domain.MemberVO;

@Mapper
public interface UserDetailsMapper {
    public MemberVO get(String username);
}
