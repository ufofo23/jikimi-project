package org.scoula.like.property.service;

import org.scoula.map.domain.MapDetailDTO;

import java.util.List;

public interface LikePropertyService {

    public int create(int proNo, String token);

    public List<MapDetailDTO> getList(String token);

    public int delete(int proNo);
}
