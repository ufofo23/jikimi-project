package org.scoula.map.service;

import org.scoula.map.domain.MapDetailDTO;
import org.scoula.map.domain.MapVO;

import java.util.List;

public interface MapService {
    public List<MapVO> getAllAddress();

    List<MapVO> getAddressListMove(double lat, double lon, int zoomLevel);

    List<MapVO> getAddressListMoveCluster(double lat, double lon, int zoomLevel);

    public List<MapDetailDTO> getAddressDetails(Long id);

}