package org.scoula.map.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.scoula.map.domain.MapVO;
import org.scoula.map.mapper.MapMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@RequiredArgsConstructor
public class MapServiceImpl implements MapService {

    final private MapMapper mapper;

    @Override
    public List<MapVO> getAllAddress() {
        log.info("getAddressList*********************************");
        return mapper.getAdressList().stream().toList();
    }
}