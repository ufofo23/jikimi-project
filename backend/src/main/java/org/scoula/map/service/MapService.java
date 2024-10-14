package org.scoula.map.service;

import org.scoula.map.domain.MapClusterVO;
import org.scoula.map.domain.MapDetailDTO;
import org.scoula.map.domain.MapVO;

import java.util.List;

public interface MapService {
    List<MapVO> getAllAddress();

    List<MapVO> getAddressListMoveAll(double lat, double lon, int zoomLevel);

    List<MapClusterVO> getAddressListMoveClusterAll(double lat, double lon, int zoomLevel, int page, int limit);

    List<MapDetailDTO> getAddressDetails(Long id);
    List<MapDetailDTO> getReportAddressDetails(Long id);

}