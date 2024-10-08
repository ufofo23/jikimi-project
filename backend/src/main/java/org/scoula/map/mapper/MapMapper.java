package org.scoula.map.mapper;

import org.apache.ibatis.annotations.Param;
import org.scoula.map.domain.MapClusterVO;
import org.scoula.map.domain.MapDetailDTO;
import org.scoula.map.domain.MapVO;

import java.util.List;

public interface MapMapper {
    public List<MapVO> getAddressList();

    public List<MapDetailDTO> getAddressDetails(Long id);

    public List<MapVO> getAddressListMoveAll(@Param("lat") double lat,
                                          @Param("lon") double lon,
                                          @Param("zoomLevel") int zoomLevel
    );

    public List<MapVO> getAddressListMovePropertyFilter(
                                          @Param("lat") double lat,
                                          @Param("lon") double lon,
                                          @Param("zoomLevel") int zoomLevel,
                                          @Param("property_type") int property_type
    );

    public List<MapVO> getAddressListMoveTradeFilter(@Param("lat") double lat,
                                          @Param("lon") double lon,
                                          @Param("zoomLevel") int zoomLevel,
                                          @Param("trade_type") int trade_type
    );
    public List<MapClusterVO> getAddressListMoveClusterAll(@Param("lat") double lat,
                                                        @Param("lon") double lon,
                                                        @Param("zoomLevel") int zoomLevel,
                                                        @Param("limit") int limit,
                                                        @Param("offset") int offset);

    public List<MapClusterVO> getAddressListMoveClusterPropertyFilter(
                                                        @Param("lat") double lat,
                                                        @Param("lon") double lon,
                                                        @Param("zoomLevel") int zoomLevel,
                                                        @Param("limit") int limit,
                                                        @Param("offset") int offset,
                                                        @Param("property_type") int property_type
    );
    public List<MapClusterVO> getAddressListMoveClusterTradeFilter(
                                                        @Param("lat") double lat,
                                                        @Param("lon") double lon,
                                                        @Param("zoomLevel") int zoomLevel,
                                                        @Param("limit") int limit,
                                                        @Param("offset") int offset,
                                                        @Param("trade_type") int trade_type
    );
}
