package org.scoula.map.service;

import org.scoula.map.domain.MapClusterVO;
import org.scoula.map.domain.MapDetailDTO;
import org.scoula.map.domain.MapVO;

import java.util.List;

public interface MapService {
    public List<MapVO> getAllAddress();

    List<MapVO> getAddressListMoveAll(double lat, double lon, int zoomLevel);
    List<MapVO> getAddressListMovePropertyFilter(double lat, double lon, int zoomLevel, int property_type);
    List<MapVO> getAddressListMoveTradeFilter(double lat, double lon, int zoomLevel, int trade_type);

    List<MapClusterVO> getAddressListMoveClusterAll(double lat, double lon, int zoomLevel, int page, int limit);
    List<MapClusterVO> getAddressListMoveClusterPropertyFilter(double lat, double lon, int zoomLevel, int property_type, int page, int limit);
    List<MapClusterVO> getAddressListMoveClusterTradeFilter(double lat, double lon, int zoomLevel, int property_type, int page, int limit);

    public List<MapDetailDTO> getAddressDetails(Long id);

}