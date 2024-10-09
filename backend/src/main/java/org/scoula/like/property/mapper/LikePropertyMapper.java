package org.scoula.like.property.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.scoula.map.domain.MapDetailDTO;

import java.util.List;

@Mapper
public interface LikePropertyMapper {

    public int create(@Param("proNo") int proNo, @Param("userId") String userId);

    public List<MapDetailDTO> getList(String userId);

    public int delete(int proNo);
}
