package org.scoula.map.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.apache.ibatis.annotations.Param;
import org.scoula.map.domain.MapClusterVO;
import org.scoula.map.domain.MapDetailDTO;
import org.scoula.map.domain.MapVO;
import org.scoula.map.mapper.MapMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;

@Log4j
@Service
@RequiredArgsConstructor
public class MapServiceImpl implements MapService {

    final private MapMapper mapper;

    @Override
    public List<MapVO> getAllAddress() {
        return mapper.getAddressList().stream().toList();
    }

    @Override
    public List<MapVO> getAddressListMoveAll(@Param("lat") double lat, @Param("lon") double lon, @Param("zoomLevel") int zoomLevel) {
        return mapper.getAddressListMoveAll(lat, lon, zoomLevel);
    }

    @Override
    public List<MapClusterVO> getAddressListMoveClusterAll(@Param("lat") double lat, @Param("lon") double lon, @Param("zoomLevel") int zoomLevel, @Param("page") int page, @Param("limit") int limit) {
        int offset = (page - 1) * limit;  // Calculate offset based on page and limit
        return mapper.getAddressListMoveClusterAll(lat, lon, zoomLevel, limit, offset);  // Pass limit and offset to the mapper
    }

    @Override
    public List<MapDetailDTO> getAddressDetails(Long id) { // 반환 타입을 List로 변경
        List<MapDetailDTO> addressDetails = mapper.getAddressDetails(id); // List로 받음
        if (addressDetails.isEmpty()) {
            throw new NoSuchElementException("Address not found for id: " + id);
        }
        return addressDetails;
    }
}