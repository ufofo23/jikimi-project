package org.scoula.map.mapper;

import org.apache.ibatis.annotations.Param;
import org.scoula.map.domain.MapClusterVO;
import org.scoula.map.domain.MapDetailDTO;
import org.scoula.map.domain.MapVO;

import java.util.List;

public interface MapMapper {
    List<MapVO> getAddressList();

    List<MapDetailDTO> getAddressDetails(Long id);

    List<MapVO> getAddressListMoveAll(@Param("lat") double lat, @Param("lon") double lon, @Param("zoomLevel") int zoomLevel);

    List<MapClusterVO> getAddressListMoveClusterAll(@Param("lat") double lat, @Param("lon") double lon, @Param("zoomLevel") int zoomLevel, @Param("limit") int limit, @Param("offset") int offset);
}
