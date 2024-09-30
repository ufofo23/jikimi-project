package org.scoula.map.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
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
    public List<MapDetailDTO> getAddressDetails(Long id) { // 반환 타입을 List로 변경
        List<MapDetailDTO> addressDetails = mapper.getAddressDetails(id); // List로 받음
        if (addressDetails.isEmpty()) {
            throw new NoSuchElementException("Address not found for id: " + id);
        }
        return addressDetails;
    }
}