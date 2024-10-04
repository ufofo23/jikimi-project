package org.scoula.map.mapper;

import org.apache.ibatis.annotations.Param;
import org.scoula.map.domain.MapDetailDTO;
import org.scoula.map.domain.MapVO;

import java.util.List;

public interface MapMapper {
    public List<MapVO> getAdressList();

    public List<MapDetailDTO> getAddressDetails(Long id);

    public List<MapVO> getAddressListMove(@Param("lat") double lat,
                                          @Param("lon") double lon,
                                          @Param("zoomLevel") int zoomLevel);

    public List<MapVO> getAddressListMoveCluster(@Param("lat") double lat,
                                                 @Param("lon") double lon,
                                                 @Param("zoomLevel") int zoomLevel);
}
