package org.scoula.map.service;

import com.nimbusds.openid.connect.sdk.claims.Address;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.apache.ibatis.annotations.Param;
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
        return mapper.getAdressList().stream().toList();
    }

    @Override
    public List<MapVO> getAddressListMove(@Param("lat") double lat,
                                            @Param("lon") double lon,
                                            @Param("zoomLevel") int zoomLevel) {
        log.info("****************** getAddressListMove: "+ zoomLevel + lat +"********37"+ lon + "***********127");
        return mapper.getAddressListMove(lat, lon, zoomLevel);
    }

    @Override
    public List<MapVO> getAddressListMoveCluster(@Param("lat") double lat,
                                                 @Param("lon") double lon,
                                                 @Param("zoomLevel") int zoomLevel) {
        log.info("****************** getAddressListMove: "+ zoomLevel);
        return mapper.getAddressListMoveCluster(lat, lon, zoomLevel);
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