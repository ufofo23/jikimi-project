package org.scoula.like.dictionary.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.scoula.dictionary.domain.DictionaryVO;

import java.util.List;

@Mapper
public interface LikeDictionaryMapper {

    public int create(@Param("dicNo")int dicNo, @Param("userId") String userId);

    public List<DictionaryVO> getList(String userId);
}
